import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  RxBool isPasswordValid = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var isPasswordHidden = true.obs;
  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);

          Get.offAllNamed(Routes.LOGIN);
          Get.snackbar(
            "Berhasil",
            "Silahkan Login dengan Password Baru",
            backgroundColor: Colors.white70,
            snackStyle: SnackStyle.FLOATING,
            borderRadius: 10.0,
            margin: const EdgeInsets.all(16.0),
            colorText: Colors.black,
            duration: const Duration(seconds: 3),
            animationDuration: const Duration(milliseconds: 300),
            overlayBlur: 0.5,
            overlayColor: Colors.black54,
            forwardAnimationCurve: Curves.easeOutQuart,
            reverseAnimationCurve: Curves.easeInOutQuart,
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            mainButton: TextButton(
              onPressed: () {
                // Aksi tambahan
              },
              child: const Text(
                "Tutup",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
                "terjadi kesalahan", "Password lemah, wajib 6 karakter",
                backgroundColor: Colors.redAccent);
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'tidak dapat membuat password baru, hubungi admin',
            backgroundColor: Colors.white60,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          // Get.snackbar("terjadi kesalahan",
          //     "tidak dapat membuat password baru, hubungi admin",
          //     backgroundColor: Colors.redAccent);
        }
      } else {
        Get.snackbar(
          'Error',
          'password baru harus diubah',
          backgroundColor: Colors.white60,
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
        // Get.snackbar("Terjadi kesalahan", "password baru harus diubah",
        //     backgroundColor: Colors.redAccent);
      }
    } else {
      Get.snackbar(
        'Error',
        'password baru wajid diisi',
        backgroundColor: Colors.white60,
        icon: const Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
      // Get.snackbar("Terjadi kesalahan", "password baru wajid diisi",
      //     backgroundColor: Colors.redAccent);
    }
  }
}
