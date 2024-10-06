import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:get/get.dart';
import './landing_page_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
                      Container(
          color: Colors.white,
        ),
        Image.asset(
          "assets/images/Motif.png",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
              LandingPage(controller: controller),
            ],
          ),
          bottomNavigationBar: Obx( ()=> BottomNavigationBar(
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
        ))
      ],
    );
  }
}

