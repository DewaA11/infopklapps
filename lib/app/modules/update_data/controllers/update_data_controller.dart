// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class UpdateDataController extends GetxController {
  RxBool isloading = false.obs;
  final TextEditingController alamatC = TextEditingController();
  final TextEditingController emailpC = TextEditingController();
  final TextEditingController syaratC = TextEditingController();
  final TextEditingController detailC = TextEditingController();
  final TextEditingController fotoC = TextEditingController();
  final TextEditingController jurusanC = TextEditingController();
  final TextEditingController ketenC = TextEditingController();
  final TextEditingController namapC = TextEditingController();
  final TextEditingController namatC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateData(String namaPt) async {
    if (ketenC.text.isNotEmpty &&
        jurusanC.text.isNotEmpty &&
        syaratC.text.isNotEmpty) {
      isloading.value = true;
      try {
        await firestore.collection("Tempat").doc(namaPt).update({
          "nama_pt":namapC.text,
          "nama_terang": namatC.text,
          "email_pt":emailpC.text,
          "detail_pt": detailC.text,
          "alamat_pt": alamatC.text,
          "ketentuan_pt": ketenC.text,
          "jurusan_pt": jurusanC.text,
          "syarat_pt": syaratC.text
        });
        Get.snackbar("Berhasil", "menambahkan data",
            backgroundColor: Colors.white,
            icon: const Icon(Icons.check, color: Colors.green));

        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.snackbar('Error', 'Gagal Hapus foto',
            backgroundColor: Colors.white);
        const Icon(Icons.close, color: Colors.red);
      } finally {
        isloading.value = false;
      }
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("mahasiswa").doc(uid).snapshots();
  }
}
