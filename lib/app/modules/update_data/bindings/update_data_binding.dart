import 'package:get/get.dart';

import '../controllers/update_data_controller.dart';

class UpdateDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateDataController>(
      () => UpdateDataController(),
    );
  }
}
