import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rempahsisv2/app/modules/home/views/about_view.dart';
import 'package:rempahsisv2/app/modules/image_scan/controllers/image_scan_controller.dart';
import 'package:rempahsisv2/app/modules/image_scan/views/image_scan_view.dart';
import 'package:rempahsisv2/app/modules/list_rempah/views/list_rempah_view.dart';
import '../../list_rempah/controllers/list_rempah_controller.dart';
import './landing_page_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ListRempahController());
    Get.put(ImageScanController());
    var childrenComponets = [
      LandingPage(controller: controller),
      ListRempahView(),
      ImageScanView(),
      AboutView(),
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() => childrenComponets[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
              onTap: controller.onTabTapped,
              currentIndex: controller.currentIndex.value,
              unselectedItemColor: Color(0xffCE8D51),
              selectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Beranda"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: "Daftar"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.photo_camera), label: "Scan"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.more_vert), label: "Lainnya"),
              ])),
    );
  }
}
