import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KuesionerHasilController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> kuesionerhasil() {
    return _firestore.collection('kuesioner').snapshots();
  }


   Future<void> deleteAllkuesioner() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('kuesioner')
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
