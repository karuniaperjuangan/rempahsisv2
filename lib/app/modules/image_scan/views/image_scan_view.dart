import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/components/appbar/rempah_sis_appbar.dart';
import 'package:myapp/app/constant/colors.dart';

import '../controllers/image_scan_controller.dart';

class ImageScanView extends GetView<ImageScanController> {
  const ImageScanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RempahSISAppbar(),
      body: Container(
        alignment: Alignment.topCenter,
        color: RempahSISColor.lightGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Obx(
                  () => controller.imagePath.value.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.image, size: 100),
                            const Text('Tidak ada gambar yang dipih.'),
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
            ),
            SizedBox(height: 20),
            ShadowedContainer(
              child: Obx(() => Text(
                    controller.classificationResult.value.isEmpty
                        ? 'Klik tombol kamera di bawah untuk mulai mengidentifikasi rempah'
                        : controller.classificationResult.value,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  )),
            ),
            SizedBox(height: 20),
            Obx(() => controller.classificationDescription.isNotEmpty
                ? ShadowedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.classificationDescription.value,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: RempahSISColor.darkBrown,
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed('/rempah-detail', arguments: {
                              'id': controller.classificationId.value
                            });
                          },
                          child: const Text('Lihat detail rempah',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: RempahSISColor.darkBrown,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  )
                : SizedBox()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
        backgroundColor: RempahSISColor.lightBrown,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            builder: (BuildContext context) {
              return Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera_alt, color: Colors.brown[800]),
                    title: Text('Gunakan Kamera',
                        style: TextStyle(
                          color: Colors.brown[800],
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      controller.pickImage(fromCamera: true);
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.photo_library, color: Colors.brown[800]),
                    title: Text('Ambil dari Galeri',
                        style: TextStyle(
                          color: Colors.brown[800],
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      controller.pickImage(fromCamera: false);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(color: Colors.white, Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ShadowedContainer extends StatelessWidget {
  const ShadowedContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: -2,
          )
        ],
      ),
      child: child,
    );
  }
}
