import 'package:get/get.dart';

import '../controllers/addtdatapkl_controller.dart';

class AddtdatapklBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddtdatapklController>(
      () => AddtdatapklController(),
    );
  }
}
