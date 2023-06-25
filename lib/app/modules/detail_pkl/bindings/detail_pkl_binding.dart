import 'package:get/get.dart';

import '../controllers/detail_pkl_controller.dart';

class DetailPklBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPklController>(
      () => DetailPklController(),
    );
  }
}
