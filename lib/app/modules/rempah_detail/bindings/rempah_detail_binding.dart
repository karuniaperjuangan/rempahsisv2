import 'package:get/get.dart';

import '../controllers/rempah_detail_controller.dart';

class RempahDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RempahDetailController>(
      () => RempahDetailController(),
    );
  }
}
