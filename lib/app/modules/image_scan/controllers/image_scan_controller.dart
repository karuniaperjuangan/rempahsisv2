
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/app/models/rempah.dart';
import 'package:myapp/utils/fetch_rempah.dart';
import 'package:onnxruntime/onnxruntime.dart';
import 'dart:io';

class ImageScanController extends GetxController {
  final count = 0.obs;
  final imagePath = ''.obs;
  final classificationId = 0.obs;
  final classificationResult = ''.obs;
  final classificationDescription = ''.obs;
  final ImagePicker _picker = ImagePicker();


  void increment() => count.value++;

  Future<void> pickImage({bool fromCamera=false}) async {
    final XFile? image = await _picker.pickImage(source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    final List<Rempah> rempahs = await loadRempahJSON('assets/rempah.json');
    if (image != null) {
      imagePath.value = image.path;
      final maxIndex = await classifyImage(File(image.path));
      if (maxIndex != null) {
        classificationId.value = maxIndex;
        classificationResult.value = rempahs.firstWhere((element) => element.id == maxIndex).namaRempah;
        classificationDescription.value = rempahs.firstWhere((element) => element.id == maxIndex).ikhtisar;
      }
    }
  }

    Future<int?> classifyImage(File image) async {
    // Load the ONNX model from the assets folder
    const path = 'assets/best.onnx';
    final rawAssetFile = await rootBundle.load(path);
    
    // Convert the loaded model to a byte array
    final bytes = rawAssetFile.buffer.asUint8List();
    
    // Create an ONNX runtime session from the byte array
    final session = OrtSession.fromBuffer(bytes, OrtSessionOptions());
    
    // Create options for running the ONNX model
    final runOptions = OrtRunOptions();
    
    // Convert the image to a tensor that the ONNX model can process
    final inputOrt = OrtValueTensor.createTensorWithDataList(
      Float32List.fromList(await imageToFloatTensor(image)),
      [1, 3, 640, 640],
    );
    
    // Run the ONNX model with the input tensor and get the output tensor
    final output = session.run(
      runOptions,
      {'images': inputOrt},
      ['output0'],
    ).first as OrtValueTensor;
    
    // Extract the output data from the tensor
    List<double> outputData = output.value.first;
    
    // If the maximum value in the output data is less than 0.4, the model is unsure
    final maxValue = outputData.reduce((a, b) => a > b ? a : b);
    if (maxValue < 0.4) {
      classificationResult.value = 'Rempah tidak terdeteksi';
      classificationDescription.value = '';
      return null;
    }
    // Get the index of the maximum value in the output data
    final maxIndex = outputData.indexWhere((element) => element == maxValue);
    
    // Load the JSON file that maps indices to classification labels
    final rawAssetFile2 = await rootBundle.load('assets/rempahsis_model_map.json');
    final json = String.fromCharCodes(rawAssetFile2.buffer.asUint8List());
    
  
    // Decode the JSON file to a map
    final Map<String, dynamic> map = jsonDecode(json);

    //Release the resources
    session.release();
    runOptions.release();
    inputOrt.release();
    return map[maxIndex.toString()];
  }
  
  Future<List<double>> imageToFloatTensor(File image) async {
    // Read the image file as bytes
    final bytes = await image.readAsBytes();
    
    // Convert the bytes to a Uint8List
    var rgbaUints = Uint8List.view(bytes.buffer);
    
    // Decode the image from the byte array
    Image img = decodeImage(rgbaUints)!;
    
    // Resize the image to 640x640 pixels without maintaining the aspect ratio
    img = copyResize(img, width: 640, height: 640, maintainAspect: false);
    
    // Convert the resized image to a byte array
    rgbaUints = Uint8List.view(img.getBytes().buffer);
    
    // Create an indexed list of the byte array
    final indexed = rgbaUints.indexed;
    
    // Convert the image bytes to a list of normalized float values
    // Also align the RGB channels to match the ONNX model input format as Flutter uses format [ R G B R G B ... ]
    // while ONNX expects [ R R R ... G G G ... B B B ... ]
    return [
      ...indexed.where((e) => e.$1 % 3 == 0).map((e) => e.$2 / 255), // Red channel
      ...indexed.where((e) => e.$1 % 3 == 1).map((e) => e.$2 / 255), // Green channel
      ...indexed.where((e) => e.$1 % 3 == 2).map((e) => e.$2 / 255)  // Blue channel
    ];
  }

}