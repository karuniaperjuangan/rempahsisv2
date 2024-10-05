import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_rempah_controller.dart';

class ListRempahView extends GetView<ListRempahController> {
  const ListRempahView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListRempahView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ListRempahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
