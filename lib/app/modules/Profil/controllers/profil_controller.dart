import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infopkl/app/routes/app_pages.dart';

class ProfilController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String? uid = auth.currentUser!.uid;

    yield* firestore.collection("mahasiswa").doc(uid).snapshots();
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar(
      'Sukses Logout',
      'semoga hari mu menyenangkan',
      backgroundColor: Colors.white70,
      icon: const Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('alert'),
          content: const Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                logout(); // Panggil fungsi logout dari controller
              },
            ),
          ],
        );
      },
    );
  }
}
