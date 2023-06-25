import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages, library_prefixes
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class DetailPKLController extends GetxController {
  late String nama;
  DetailPKLController({required this.nama});
  RxBool isloading = false.obs;
  RxBool isDeleting = false.obs;
  RxDouble rating = 0.0.obs;
  final TextEditingController namapC = TextEditingController();
  final TextEditingController fotoC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  XFile? photo;

  final ImagePicker picker = ImagePicker();

  void ambilFoto() async {
    photo =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (photo != null) {
      addGambar();
    } else {
      print(photo);
    }
    update();
  }

  void addGambar() async {
    //Menampilkan dialog loading
    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50,
        ),
      ),
      barrierDismissible: false,
    );

    final tempat = FirebaseFirestore.instance
        .collection('Tempat')
        .doc(nama)
        .collection('media')
        .doc();
    String uriImageuser = '';

    File file = File(photo!.path);

    // Kompresi gambar sebelum mengunggah
    File compressedImage = await compressImage(file);

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('imagesuser');
    Reference referenceImageUpload = referenceDirImage.child(uniqueFileName);

    try {
      UploadTask uploadTask = referenceImageUpload.putFile(compressedImage);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        if (snapshot.state == TaskState.running) {
          // Handle upload progress here
          double progress = snapshot.bytesTransferred / snapshot.totalBytes;
          print('Upload progress: $progress');
        }
      });

      await uploadTask;

      uriImageuser = await referenceImageUpload.getDownloadURL();
      await tempat.set({
        "uid": auth.currentUser?.uid,
        "id": tempat.id,
        "media": uriImageuser,
      });

      Get.back(); // Menutup dialog loading

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Memasukkan Data",
        onConfirm: () {
          fotoC.clear();
          Get.back();
          Get.snackbar(
            "Berhasil",
            "menambahkan data",
            backgroundColor: Colors.white,
            icon: const Icon(Icons.check, color: Colors.green),
          );
        },
        textConfirm: "Oke",
      );
    } catch (e) {
      print(e);
      Get.back(); // Menutup dialog loading

      Get.defaultDialog(
        title: "Error",
        middleText: "Tidak Berhasil Memasukkan Data",
      );
    } finally {
      isloading.value = false; // Stop loading
    }
  }

  Future<File> compressImage(File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int random = DateTime.now().millisecondsSinceEpoch;

    Im.Image? image = Im.decodeImage(imageFile.readAsBytesSync());
    Im.Image? smallerImage = Im.copyResize(image!,
        width: 500); // Ubah ukuran gambar sesuai kebutuhan

    File compressedImage = File('$path/img_$random.jpg')
      ..writeAsBytesSync(Im.encodeJpg(smallerImage,
          quality: 75)); // Ubah kualitas gambar sesuai kebutuhan

    return compressedImage;
  }

  Future<void> hapusGambar(String id, String fotoUrl) async {
    try {
      // Hapus data foto dari Firebase Cloud Firestore
      await FirebaseFirestore.instance
          .collection('Tempat')
          .doc(nama)
          .collection('media')
          .doc(id)
          .delete();

      // Hapus foto dari Firebase Cloud Storage
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(fotoUrl)
          .delete();
      // Tampilkan snackbar jika berhasil dihapus
      Get.snackbar(
        'Sukses',
        'Foto berhasil dihapus',
        backgroundColor: Colors.white60,
        icon: const Icon(Icons.check, color: Colors.green),
      );
    } catch (e) {
      print(e);
      // Tampilkan snackbar jika terjadi kesalahan
      Get.snackbar('Error', 'Terjadi kesalahan saat menghapus foto',
          backgroundColor: Colors.white);
      const Icon(Icons.close, color: Colors.red);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamMedia(String name) async* {
    yield* firestore
        .collection("Tempat")
        .doc(name)
        .collection("media")
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("mahasiswa").doc(uid).snapshots();
  }
}
