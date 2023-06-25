import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../controllers/hasilrating_controller.dart';

class HasilratingView extends GetView<HasilratingController> {
  const HasilratingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Rating'),
        centerTitle: true,
        backgroundColor: const Color(0xFF000080),
        actions: [
          IconButton(
            onPressed: () {
              // Ganti dengan ID rating yang ingin dihapus
              controller.deleteAllRatings();
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Hasil Rating',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                color: Colors.grey.shade200,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        controller.tempat.namaPt,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: controller.tempat.ratingPt,
                        tapOnlyMode: true,
                        ignoreGestures: true,
                        minRating: 1,
                        maxRating: 5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 40,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) async {},
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'User yang menilai',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamRating(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('TIDAK ADA DATA'),
                      );
                    }
                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(bottom: 5),
                            color: Colors.grey.shade300,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              width: Get.width,
                              child: StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                stream: controller.userStream(
                                    snapshot.data!.docs[index]['uid']),
                                builder: (context, snapshotUser) {
                                  if (snapshotUser.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  Map<String, dynamic> user =
                                      snapshotUser.data!.data()!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      RatingBar.builder(
                                        initialRating: snapshot
                                            .data!.docs[index]['value']
                                            .toDouble(),
                                        tapOnlyMode: true,
                                        ignoreGestures: true,
                                        minRating: 1,
                                        maxRating: 5,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) async {},
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Total Rating'),
    //     centerTitle: true,
    //     backgroundColor: const Color(0xFF000080),
    //   ),
    //   body: Container(
    //     width: Get.width,
    //     height: Get.height,
    //     child: Card(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Card(
    //             margin: const EdgeInsets.only(bottom: 20),
    //             color: Colors.grey.shade300,
    //             child: Container(
    //                 margin: const EdgeInsets.all(10),
    //                 padding: const EdgeInsets.all(10),
    //                 child: Column(
    //                   children: [
    //                     Text(controller.tempat.namaPt),
    //                     RatingBar.builder(
    //                       initialRating: controller.tempat.ratingPt,
    //                       tapOnlyMode: true,
    //                       ignoreGestures: true,
    //                       minRating: 1,
    //                       maxRating: 5,
    //                       direction: Axis.horizontal,
    //                       allowHalfRating: true,
    //                       itemCount: 5,
    //                       itemSize: 40,
    //                       itemBuilder: (context, _) => const Icon(
    //                         Icons.star,
    //                         color: Colors.amber,
    //                       ),
    //                       onRatingUpdate: (rating) async {},
    //                     ),
    //                   ],
    //                 )),
    //           ),
    //           Expanded(
    //             child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    //               stream: controller.streamRating(),
    //               builder: (context, snapshot) {
    //                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                   return const Center(
    //                     child: CircularProgressIndicator(),
    //                   );
    //                 }
    //                 if (snapshot.data!.docs.isEmpty) {
    //                   return const Center(
    //                     child: Text('TIDAK ADA DATA'),
    //                   );
    //                 }
    //                 return ListView.separated(
    //                     itemCount: snapshot.data!.docs.length,
    //                     separatorBuilder: (context, index) {
    //                       return Container(
    //                         height: 3,
    //                         width: Get.width,
    //                         color: Colors.grey,
    //                       );
    //                     },
    //                     itemBuilder: (context, index) {
    //                       return Card(
    //                         margin: const EdgeInsets.only(bottom: 20),
    //                         color: Colors.grey.shade300,
    //                         child: Container(
    //                           margin: const EdgeInsets.all(10),
    //                           padding: const EdgeInsets.all(10),
    //                           width: Get.width,
    //                           child: StreamBuilder<
    //                                   DocumentSnapshot<Map<String, dynamic>>>(
    //                               stream: controller.userStream(
    //                                   snapshot.data!.docs[index]['uid']),
    //                               builder: (context, snapshotUser) {
    //                                 if (snapshotUser.connectionState ==
    //                                     ConnectionState.waiting) {
    //                                   return const CircularProgressIndicator();
    //                                 }
    //                                 Map<String, dynamic> user =
    //                                     snapshotUser.data!.data()!;
    //                                 return Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text(user['name']),
    //                                     RatingBar.builder(
    //                                       initialRating: snapshot
    //                                           .data!.docs[index]['value']
    //                                           .toDouble(),
    //                                       tapOnlyMode: true,
    //                                       ignoreGestures: true,
    //                                       minRating: 1,
    //                                       maxRating: 5,
    //                                       direction: Axis.horizontal,
    //                                       allowHalfRating: true,
    //                                       itemCount: 5,
    //                                       itemSize: 20,
    //                                       itemBuilder: (context, _) => const Icon(
    //                                         Icons.star,
    //                                         color: Colors.amber,
    //                                       ),
    //                                       onRatingUpdate: (rating) async {},
    //                                     ),
    //                                   ],
    //                                 );
    //                               }),
    //                         ),
    //                       );
    //                     });

    //                 // var data = snapTempat.data;
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
