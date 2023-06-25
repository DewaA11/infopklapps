import 'package:get/get.dart';

import '../controllers/hasilrating_controller.dart';

class HasilratingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HasilratingController>(
      () => HasilratingController(),
    );
  }
}
