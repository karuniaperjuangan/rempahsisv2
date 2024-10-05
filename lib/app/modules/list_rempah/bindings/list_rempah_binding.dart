import 'package:get/get.dart';

import '../controllers/list_rempah_controller.dart';

class ListRempahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListRempahController>(
      () => ListRempahController(),
    );
  }
}
