import 'package:get/get.dart';

import '../controllers/update_profil_controller.dart';

class UpdateProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProfilController>(
      () => UpdateProfilController(),
    );
  }
}
