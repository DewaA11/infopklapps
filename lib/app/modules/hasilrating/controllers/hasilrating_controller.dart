import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infopkl/app/data/models/modeldata.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class HasilratingController extends GetxController {
  TempatModel tempat = Get.arguments;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamRating() async* {
    yield* firestore
        .collection("Tempat")
        .doc(tempat.namaPt)
        .collection('ratings')
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream(String uid) async* {
    yield* firestore.collection("mahasiswa").doc(uid).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTempat() async* {
    yield* firestore.collection("Tempat").doc(tempat.namaPt).snapshots();
  }

Future<void> deleteAllRatings() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("Tempat")
        .doc(tempat.namaPt)
        .collection('ratings')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in snapshot.docs) {
      await documentSnapshot.reference.delete();
    }

    Get.snackbar(
      'Berhasil',
      'Semua data berhasil dihapus',
      backgroundColor: Colors.white,
      icon: const Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
    // Lakukan tindakan lain jika diperlukan setelah semua rating berhasil dihapus
  } catch (e) {
    Get.snackbar(
      'Error',
      'Tidak dapat menghapus data',
      backgroundColor: Colors.white,
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
    // Tangani kesalahan jika terjadi saat menghapus rating
    print("Error deleting ratings: $e");
  }
}
}
