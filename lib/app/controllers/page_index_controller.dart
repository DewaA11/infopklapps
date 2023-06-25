import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infopkl/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;
  TextEditingController pageC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    changePage(
        0); // Set the initial page to home when the controller is initialized
  }

  void changePage(int i) async {
    switch (i) {
      case 0:
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        Get.offAllNamed(Routes.KUESIONER);
        break;
      case 2:
        Get.offAllNamed(Routes.PROFIL);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }

    pageIndex.value =
        i; // Pembaruan nilai pageIndex setelah perpindahan halaman
  }

  // void changePage(int i) async {
  //   switch (i) {
  //     case 1:
  //       Get.offAllNamed(Routes.KUESIONER);
  //       pageIndex.value =
  //           i; // Pembaruan nilai pageIndex setelah perpindahan halaman
  //       break;
  //     case 2:
  //       Get.offAllNamed(Routes.PROFIL);
  //       pageIndex.value =
  //           i; // Pembaruan nilai pageIndex setelah perpindahan halaman
  //       break;
  //     default:
  //       Get.offAllNamed(Routes.HOME);
  //       pageIndex.value =
  //           i; // Pembaruan nilai pageIndex setelah perpindahan halaman
  //   }
  // }
}
