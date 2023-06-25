import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infopkl/app/data/models/modeldata.dart';
// import '../data/models/modeldata.dart';

class RatingDialogController extends GetxController {
  final String nama;
  FirebaseAuth auth = FirebaseAuth.instance;
  RatingDialogController({required this.nama});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxDouble averageRating = RxDouble(0.0);
  int jumlahRating = 0;
  int totalUserRating = 0;
  double ratarating = 0;
  var sudahRating = false.obs;
  final TempatModel tempat = Get.arguments;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    averageRating.value = tempat.ratingPt;
    getInitRating();
  } 

  void getInitRating() async {
    final newRatingDocRef =
        await firestore.collection('Tempat').doc(nama).collection('ratings');
    final getData = await newRatingDocRef.get();

    await Future.forEach(getData.docs, (element) {
      if (element['uid'].toString() == auth.currentUser?.uid.toString()) {
        sudahRating.value = true;
      }
    });
    update();
  }

  addRating(String namaPt, int rating) async {
  // Mengatur loading 
    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50,
        ),
      ),
      barrierDismissible: false,
    );
    final newRatingDocRef = await firestore
        .collection('Tempat')
        .doc(nama)
        .collection('ratings')
        .add({
      'uid': auth.currentUser?.uid,
      'value': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });
    getRating();
    print('Added new rating: ${newRatingDocRef.id}');
    Get.back(); // Mengatur status loading selesai
  }

  void getRating() async {
    final newRatingDocRef =
        await firestore.collection('Tempat').doc(nama).collection('ratings');
    final getData = await newRatingDocRef.get();

    await Future.forEach(getData.docs, (element) {
      totalUserRating++;
      jumlahRating = jumlahRating + int.parse((element['value']).toString());
    });

    ratarating = jumlahRating / totalUserRating;

    print(totalUserRating);
    updaterating();
    print(jumlahRating);
    update();
  }

  void updaterating() async {
    sudahRating.value = true;
    averageRating.value = ratarating;
    final newRatingDocRef = await firestore.collection('Tempat').doc(nama);

    newRatingDocRef.update({
      'rating_pt': ratarating,
    });
    final getData = await newRatingDocRef.get();
    final get = getData.data()!;

    print('Added new rating: ${get['rating_pt']}');
    averageRating.value = get['rating_pt'];
    print(averageRating.value);
    update();
  }
}


// class RatingDialogController extends GetxController {
//   final String nama;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   RatingDialogController({required this.nama});
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final RxDouble averageRating = RxDouble(0.0);
//   int jumlahRating = 0;
//   int totalUserRating = 0;
//   double ratarating = 0;
//   var sudahRating = false.obs;
//   final TempatModel tempat = Get.arguments;
//   // final RxDouble averageRating = RxDouble(0.0);

//   @override
//   void onInit() {
//     super.onInit();
//     averageRating.value = tempat.ratingPt;
//     getInitRating();
//     // calculateAverageRatingPeriodically();
//   }

//   void getInitRating() async {
//     final newRatingDocRef =
//         await firestore.collection('Tempat').doc(nama).collection('ratings');
//     final getData = await newRatingDocRef.get();
//     // final get = getData;

//     await Future.forEach(getData.docs, (element) {
//       if (element['uid'].toString() == auth.currentUser?.uid.toString()) {
//         sudahRating.value = true;
//       }
//     });
//     update();
//   }

//   addRating(String namaPt, int rating) async {
//     final newRatingDocRef = await firestore
//         .collection('Tempat')
//         .doc(nama)
//         .collection('ratings')
//         .add({
//       'uid': auth.currentUser?.uid,
//       'value': rating,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//     getRating();
//     print('Added new rating: ${newRatingDocRef.id}');
//   }

//   void getRating() async {
//     final newRatingDocRef =
//         await firestore.collection('Tempat').doc(nama).collection('ratings');
//     final getData = await newRatingDocRef.get();
//     // final get = getData;

//     await Future.forEach(getData.docs, (element) {
//       totalUserRating++;
//       jumlahRating = jumlahRating + int.parse((element['value']).toString());
//     });

//     ratarating = jumlahRating / totalUserRating;

//     print(totalUserRating);
//     updaterating();
//     print(jumlahRating);
//     update();
//   }

//   void updaterating() async {
//     sudahRating.value = true;
//     averageRating.value = ratarating;
//     final newRatingDocRef = await firestore.collection('Tempat').doc(nama);

//     newRatingDocRef.update({
//       'rating_pt': ratarating,
//     });
//     final getData = await newRatingDocRef.get();
//     final get = getData.data()!;

//     print('Added new rating: ${get['rating_pt']}');
//     averageRating.value = get['rating_pt'];
//     print(averageRating.value);
//     update();
//   }
// }
  

  //   @override
//   void onInit() {
//     super.onInit();
//     // calculateAverageRatingPeriodically();
//     getRating();
//   }

//   // Future<void> calculateAverageRatingPeriodically() async {
//   //   while (true) {
//   //     await Future.delayed(Duration(
//   //         minutes:
//   //             1)); // Hitung rata-rata setiap 1 menit (sesuaikan dengan kebutuhan Anda)
//   //     final ratingsSnapshot = await firestore
//   //         .collection('Tempat')
//   //         .doc('nama')
//   //         .collection('ratings')
//   //         .get();
//   //     final ratings = ratingsSnapshot.docs;

//   //     if (ratings.isEmpty) {
//   //       averageRating.value = 0.0;
//   //     } else {
//   //       final totalRating = ratings.fold<double>(
//   //           0.0, (sum, rating) => sum + rating.data()['value']);
//   //       averageRating.value = totalRating / ratings.length;
//   //     }

//   //     void listenToRatingChanges() {
//   //       firestore
//   //           .collection('Tempat')
//   //           .doc(nama)
//   //           .collection('ratings')
//   //           .snapshots()
//   //           .listen((snapshot) {
//   //         final ratings = snapshot.docs;
//   //         if (ratings.isEmpty) {
//   //           averageRating.value = 0.0;
//   //         } else {
//   //           final totalRating = ratings.fold<double>(
//   //               0.0, (sum, rating) => sum + rating.data()['value']);
//   //           averageRating.value = totalRating / ratings.length;
//   //         }
//   //       });
//   //     }
//   //   }
// }
//}
