import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infopkl/app/routes/app_pages.dart';
import 'package:firebase_storage/firebase_storage.dart' as store;

class UpdateProfilController extends GetxController {
  RxBool isloading = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController npmC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  store.FirebaseStorage storage = store.FirebaseStorage.instance;

  //untuk ambil gambar di galeri
  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
      print(image!.name.split(".").last);
      print(image!.path);
    } else {
      print(image);
    }
    update();
  }

  void updateProfile(String uid) async {
    if (npmC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isloading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        if (image != true) {
          // proses upload image ke storage
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('$uid/profile.$ext').putFile(file);
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();

          data.addAll({"profile": urlImage});
        }

        await firestore.collection("mahasiswa").doc(uid).update(data);
        Get.snackbar(
          'Sukses',
          'Update Profil',
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        Get.offAllNamed(Routes.PROFIL);
      } catch (e) {
        Get.snackbar(
          'Error',
          'Tidak ada perubahan di profil anda',
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      } finally {
        isloading.value = false;
      }
    }
  }
}
