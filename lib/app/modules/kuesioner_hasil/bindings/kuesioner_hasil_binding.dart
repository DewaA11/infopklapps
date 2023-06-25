import 'package:get/get.dart';

import '../controllers/kuesioner_hasil_controller.dart';

class KuesionerHasilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KuesionerHasilController>(
      () => KuesionerHasilController(),
    );
  }
}
