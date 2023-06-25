import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as gambarpkl;
import 'package:infopkl/app/routes/app_pages.dart';

class AddtdatapklController extends GetxController {
  RxBool isloading = false.obs;

  final TextEditingController namapC = TextEditingController();
  final TextEditingController namatC = TextEditingController();
  final TextEditingController detailC = TextEditingController();
  final TextEditingController ketenC = TextEditingController();
  final TextEditingController jurusanC = TextEditingController();
  final TextEditingController alamatC = TextEditingController();
  final TextEditingController emailpC = TextEditingController();
  final TextEditingController syaratC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  gambarpkl.FirebaseStorage storage = gambarpkl.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      print(image!.name);
      print(image!.name.split(".").last);
      print(image!.path);
    } else {
      print(image);
    }
    update();
  }

  void addTempat(
      String namaPT,
      String namaTerang,
      String detailPT,
      String ketentuan,
      String jurusan,
      String alamat,
      String email,
      String persyaratan) async {
    if (namaPT.isEmpty ||
        namaTerang.isEmpty ||
        detailPT.isEmpty ||
        ketentuan.isEmpty ||
        jurusan.isEmpty ||
        alamat.isEmpty ||
        email.isEmpty ||
        persyaratan.isEmpty) {
      Get.snackbar(
        'Peringatan',
        'Semua isian harus diisi',
        backgroundColor: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.yellow),
      );
      return;
    }
    // Get.dialog(
    //   Center(
    //     child: SpinKitCircle(
    //       color: Colors.blue,
    //       size: 50,
    //     ),
    //   ),
    //   barrierDismissible: false,
    // );
    isloading.value = true;
    CollectionReference tempat = firestore.collection('Tempat');
    String uriImage = '';

    File file = File(image!.path);

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageUpload = referenceDirImage.child(uniqueFileName);

    referenceImageUpload.putFile(file);

    try {
      await referenceImageUpload.putFile(file);
      uriImage = await referenceImageUpload.getDownloadURL();
      await tempat.doc(namaPT).set({
        "nama_pt": namaPT,
        "nama_terang": namaTerang,
        "detail_pt": detailPT,
        "ketentuan_pt": ketentuan,
        "jurusan_pt": jurusan,
        "alamat_pt": alamat,
        "email_pt": email,
        "syarat_pt": persyaratan,
        "rating_pt": 0,
        "foto_PT": uriImage,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Memasukkan Data",
        onConfirm: () {
          namapC.clear();
          namatC.clear();
          detailC.clear();
          ketenC.clear();
          jurusanC.clear();
          alamatC.clear();
          emailpC.clear();
          syaratC.clear();
          Get.back();
          Get.offAllNamed(Routes.PROFIL);
          Get.snackbar("Berhasil", "menambahkan data",
              backgroundColor: Colors.white,
              icon: const Icon(Icons.check, color: Colors.green));
        },
        textConfirm: "Okay",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
          title: "Error",
          middleText: "Tidak Berhasil Memasukkan Data",
          onConfirm: () {
            Get.snackbar('Error', 'Gagal Menambahkan data',
                backgroundColor: Colors.white);
            const Icon(Icons.close, color: Colors.red);
          });
    } finally {
      isloading.value = false;
    }
  }
}

// class AddtdatapklController extends GetxController {
//   RxBool isloading = false.obs;

//   final TextEditingController namapC = TextEditingController();
//   final TextEditingController detailC = TextEditingController();
//   final TextEditingController ketenC = TextEditingController();
//   final TextEditingController jurusanC = TextEditingController();
//   final TextEditingController alamatC = TextEditingController();
//   final TextEditingController emailpC = TextEditingController();
//   final TextEditingController syaratC = TextEditingController();

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   gambarpkl.FirebaseStorage storage = gambarpkl.FirebaseStorage.instance;

//   final ImagePicker picker = ImagePicker();

//   XFile? image;

//   void pickImage() async {
//     image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       print(image!.name);
//       print(image!.name.split(".").last);
//       print(image!.path);
//     } else {
//       print(image);
//     }
//     update();
//   }

//   void addTempat(String namaPT, String detailPT, String ketentuan,
//       String jurusan, String alamat, String email, String persyaratan) async {
//     CollectionReference tempat = firestore.collection('Tempat');
//     String uriImage = '';

//     File file = File(image!.path);

//     String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//     Reference referenceRoot = FirebaseStorage.instance.ref();
//     Reference referenceDirImage = referenceRoot.child('images');
//     Reference referenceImageUpload = referenceDirImage.child(uniqueFileName);

//     referenceImageUpload.putFile(file);

//     try {
//       await referenceImageUpload.putFile(file);
//       uriImage = await referenceImageUpload.getDownloadURL();
//       await tempat.doc(namaPT).set({
//         "nama_pt": namaPT,
//         "detail_pt": detailPT,
//         "ketentuan_pt": ketentuan,
//         "jurusan_pt": jurusan,
//         "alamat_pt": alamat,
//         "email_pt": email,
//         "syarat_pt": persyaratan,
//         "rating_pt": 0,
//         "foto_PT": uriImage,
//       });

//       Get.defaultDialog(
//         title: "Berhasil",
//         middleText: "Berhasil Memasukkan Data",
//         onConfirm: () {
//           namapC.clear();
//           detailC.clear();
//           ketenC.clear();
//           jurusanC.clear();
//           alamatC.clear();
//           emailpC.clear();
//           syaratC.clear();
//           Get.back();
//           Get.offAllNamed(Routes.PROFIL);
//           Get.snackbar("Berhasil", "menambahkan data",
//               backgroundColor: Colors.green);
//         },
//         textConfirm: "Okay",
//       );
//     } catch (e) {
//       print(e);
//       Get.defaultDialog(
//         title: "Error",
//         middleText: "Tidak Berhasil Memasukkan Data",
//       );
//     }
//   }
// }
