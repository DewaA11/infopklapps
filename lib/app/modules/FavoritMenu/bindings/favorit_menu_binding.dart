import 'package:get/get.dart';

import '../controllers/favorit_menu_controller.dart';

class FavoritMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritMenuController>(
      () => FavoritMenuController(),
    );
  }
}
