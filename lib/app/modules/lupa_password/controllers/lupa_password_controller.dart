import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../routes/app_pages.dart';

class LupaPasswordController extends GetxController {
  RxBool IsLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      IsLoading.value = true;
      Get.dialog(
        Center(
          child: SpinKitCircle(
            color: Colors.blue,
            size: 50,
          ),
        ),
        barrierDismissible: false,
      );
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);

        Get.back();
        Fluttertoast.showToast(
          msg: "Email Reset Password terkirim",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightGreenAccent,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        Get.offAllNamed(Routes.LOGIN);
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Tidak dapat mengirim email reset password, email tidak valid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      } finally {
        IsLoading.value = false;
        Get.back();
      }
    }
  }
}
