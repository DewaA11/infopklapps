import 'package:get/get.dart';

import '../controllers/kuesioner_controller.dart';

class KuesionerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KuesionerController>(
      () => KuesionerController(),
    );
  }
}
