import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/components/appbar/rempah_sis_appbar.dart';

import '../controllers/image_scan_controller.dart';

class ImageScanView extends GetView<ImageScanController> {
  const ImageScanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RempahSISAppbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(()=> controller.imagePath.value.isEmpty
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.image, size: 100),
                      const Text('No image selected.'),
                    ],
                  )
                  : Image.file(
                File(controller.imagePath.value),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              controller.pickImage();
            }, child: const Text('Pick Image')),
            Obx(()=> Text(
              controller.classificationResult.value,
              style: TextStyle(fontSize: 20),
            )),
          ],
        ),
      ),
    );
  }
}
