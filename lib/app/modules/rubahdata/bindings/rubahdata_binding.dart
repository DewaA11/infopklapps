import 'package:get/get.dart';

import '../controllers/rubahdata_controller.dart';

class RubahdataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RubahdataController>(
      () => RubahdataController(),
    );
  }
}
