import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../../../data/models/modeldata.dart';

class HomeController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxList<TempatModel> filteredTempat = <TempatModel>[].obs;
  RxList<TempatModel> allTempatMain = RxList<TempatModel>();
  RxList<TempatModel> allTempat = <TempatModel>[].obs;
  RxBool isSearching = false.obs;
  // RxList<TempatModel> allTempat = RxList<TempatModel>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var currentIndex = 0.obs;
  var items = [
    'https://source.unsplash.com/random/800x600',
    'https://source.unsplash.com/random/800x600',
    'https://source.unsplash.com/random/800x600',
    'https://source.unsplash.com/random/800x600',
  ];

  void search(String keyword) {
    if (keyword.isEmpty) {
      // Jika kata kunci pencarian kosong, tidak ada pencarian yang dilakukan
      // Set isSearching ke false
      isSearching.value = false;
      filteredTempat.clear();
    } else {
      // Jika kata kunci pencarian tidak kosong, lakukan pencarian
      // Set isSearching ke true
      isSearching.value = true;

      String lowercaseKeyword = keyword.toLowerCase();

      Stream<List<TempatModel>> filteredStream = firestore
          .collection("Tempat")
          .where("namaPt", isGreaterThanOrEqualTo: lowercaseKeyword)
          .where("namaPt", isLessThan: lowercaseKeyword + 'z')
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => TempatModel.fromJson(doc.data()))
            .toList();
      });

      filteredTempat.bindStream(filteredStream);
    }
  }

  void delete(String nama_pt) async {
    try {
      // Mendapatkan referensi dokumen yang akan dihapus
      var docRef = firestore.collection("Tempat").doc(nama_pt);

      // Mendapatkan data dokumen
      var docSnapshot = await docRef.get();
      var data = docSnapshot.data();

      if (data != null) {
        // Mendapatkan URL foto dari data
        var foto_PT = data['foto_PT'];

        // Menghapus dokumen dari Firestore
        await docRef.delete();

        // Menghapus foto dari Firebase Storage
        var storageRef = FirebaseStorage.instance.refFromURL(foto_PT);
        await storageRef.delete();

        Get.snackbar("Berhasil ", "Hapus data",
            backgroundColor: Colors.white,
            icon: const Icon(Icons.check, color: Colors.green));
      }
    } catch (e) {
      // Get.snackbar('Error', 'Gagal Hapus foto', backgroundColor: Colors.white);
      // const Icon(Icons.close, color: Colors.red);
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void launchMap(String address) async {
    final url = 'https://maps.google.com/?q=$address';

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      Get.snackbar("Terjadi kesalahan", "Tidak dapat membuka Gmaps",
          backgroundColor: Colors.red);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTempat() async* {
    yield* firestore.collection("Tempat").snapshots();
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> streamTempat() async* {
  //   yield* firestore.collection("Tempat").get().asStream();
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("mahasiswa").doc(uid).snapshots();
  }
}
