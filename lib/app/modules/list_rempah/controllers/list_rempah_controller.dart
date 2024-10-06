import 'dart:convert';
import 'dart:io';
import 'package:myapp/app/models/rempah.dart';
import 'package:path_provider/path_provider.dart';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ListRempahController extends GetxController {
  //TODO: Implement ListRempahController

  final count = 0.obs;
  late Future future;

  var isInitialized = false.obs;

  var dataRempah = <Rempah>[].obs;

  var dataFilter = <Rempah>[].obs;
  @override
  void onInit() async{
    // TODO: implement onInit
    dataRempah.value = await loadRempahJSON('assets/rempah.json');
    dataFilter = dataRempah;
    super.onInit();
    isInitialized.value = true;
  }

  var hasil = <Rempah>[].obs;
  void filter(String kata) {
    if(kata.isEmpty){
      hasil.value =dataRempah;
    }
    else{
      hasil.value = dataRempah.where((x) => x.namaRempah.toLowerCase().contains(kata)).toList();
    }
    
    dataFilter = hasil;
    print(dataFilter);
  }
  void increment() => count.value++;

  Future<List<Rempah>> loadRempahJSON(String path) async{
    final asset = await rootBundle.loadString(path);
    return rempahFromJson(asset);
    }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
