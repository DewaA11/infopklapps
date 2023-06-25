import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  var isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool isPasswordValid = false.obs;
  TextEditingController currC = TextEditingController();
  TextEditingController newC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePass() async {
    if (currC.text.isNotEmpty &&
        newC.text.isNotEmpty &&
        confirmC.text.isNotEmpty) {
      if (newC.text == confirmC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currC.text);

          await auth.currentUser!.updatePassword(newC.text);

          Get.back();

          Get.snackbar(
            "Sukses",
            "Kuesioner berhasil disimpan",
            backgroundColor: Colors.white,
            icon: const Icon(Icons.check, color: Colors.green),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar(
              'Error',
              'password lama anda salah',
              backgroundColor: Colors.white60,
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
          } else {
            Get.snackbar(
              'Error',
              "{$e.code.toLowerCase()}",
              backgroundColor: Colors.white60,
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
            // Get.snackbar("Terjadi kesalahan", "{$e.code.toLowerCase()}",
            //     backgroundColor: Colors.red);
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Tidak dapat update password',
            backgroundColor: Colors.white60,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar(
          'Error',
          'Confirm passoword tidak sesuai',
          backgroundColor: Colors.white60,
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'semua isian harus diisi',
        backgroundColor: Colors.white60,
        icon: const Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
      // Get.snackbar("Terjadi kesalahan", "Semua isian harus diisi",
      //     backgroundColor: Colors.red);
    }
  }
}
