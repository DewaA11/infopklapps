import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  var isPasswordHidden = true.obs;
  RxBool isPasswordValid = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);

        print(userCredential);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                backgroundColor: Colors.white,
                content: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: const Text(
                          "Lakukan verifikasi sekarang, jika verifikasi belum terkirim maka klik 'kirim ulang' dan jika tidak ada di kontak masuk kamu bisa cek di email spam",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                middleText: "PERINGATAN",
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Tutup"),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await userCredential.user!.sendEmailVerification();
                          Get.back();
                          Get.snackbar(
                            'Berhasil',
                            'Pesan Verifikasi telah terkirim',
                            backgroundColor: Colors.white,
                            icon: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          );
                          isLoading.value = false;
                        } catch (e) {
                          isLoading.value = false;
                          Get.snackbar(
                            'Error',
                            'tidak dapat mengirim email hubungin admin',
                            backgroundColor: Colors.white,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text("Kirim ulang"))
                ]);
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar(
            'Error',
            'email tidak terdaftar',
            backgroundColor: Colors.white60,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            'Error',
            'password salah',
            backgroundColor: Colors.white60,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'tidak dapat login',
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
        'email dan password wajib diisi',
        backgroundColor: Colors.white60,
        icon: const Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  void sendEmailToAdmin() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'dewa19pratama@gmail.com',
      queryParameters: {'subject': 'Permintaan Sign Up'},
    );

    final String url = params.toString();

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
      Get.back();
      Get.snackbar(
        'Sukses',
        'email berhasil terkirim',
        backgroundColor: Colors.white70,
        icon: const Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      Get.snackbar(
        'Error',
        'email tidak terkirim',
        backgroundColor: Colors.white60,
        icon: const Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }
}
