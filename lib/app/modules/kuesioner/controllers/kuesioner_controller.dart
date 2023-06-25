import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KuesionerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> submitQuestionnaire(
      Map<String, dynamic> questionnaireData) async {
    try {
      // Simpan data kuesioner ke Firestore
      await _firestore.collection('kuesioner').add(questionnaireData);
      Get.snackbar("Sukses", "Kuesioner berhasil disimpan",
          backgroundColor: Colors.white,
           icon: const Icon(Icons.check, color: Colors.green),);
    } catch (error) {
      Get.snackbar("Error", "Terjadi kesalahan saat menyimpan kuesioner",
          backgroundColor: Colors.red,
           icon:
      const Icon(Icons.close, color: Colors.red));
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("mahasiswa").doc(uid).snapshots();
  }
}
