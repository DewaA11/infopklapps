import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infopkl/app/controllers/ratingcontroller.dart';
import 'package:infopkl/app/data/models/modeldata.dart';
// import '../../../controllers/Videocontroller.dart';
import '../../../controllers/detailpklcontroller.dart';
import '../../../data/models/modelmedia.dart';
// import '../../../data/models/modelvideomedia.dart';
import '../../../routes/app_pages.dart';
import '../controllers/detail_pkl_controller.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class DetailPklView extends GetView<DetailPklController> {
  DetailPklView({Key? key}) : super(key: key);
  final String nama = 'ratings';
  final TextEditingController alamatC = TextEditingController();
  final TextEditingController detailC = TextEditingController();
  final TextEditingController fotoC = TextEditingController();
  final TextEditingController jurusanC = TextEditingController();
  final TextEditingController ketenC = TextEditingController();
  final TextEditingController namapC = TextEditingController();
  final TextEditingController namatC = TextEditingController();

  final TextEditingController valueC = TextEditingController();
  final TempatModel tempat = Get.arguments;
  int ratingValue = 0;

  @override
  Widget build(BuildContext context) {
    final RatingDialogController controllerRating =
        Get.put(RatingDialogController(nama: tempat.namaPt));

    final controller = Get.put(DetailPKLController(nama: tempat.namaPt));
    namapC.text = tempat.namaPt;
    namatC.text = tempat.namaterang;
    detailC.text = tempat.detailPt;
    ketenC.text = tempat.ketentuanPt;
    jurusanC.text = tempat.jurusanPt;
    alamatC.text = tempat.alamatPt;
    fotoC.text = tempat.fotoPt;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          centerTitle: true,
          backgroundColor: const Color(0xFF000080),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                color: Colors.grey,
                child: Image.network(
                  '${tempat.fotoPt}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tempat.namaPt,
                      style: GoogleFonts.oswald(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.5),
                    ),
                    if (!controllerRating.sudahRating.value)
                      TextButton(
                        onPressed: () {
                          Get.defaultDialog(
                              content: Column(
                                children: [
                                  const Text('Berikan rating:'),
                                  const SizedBox(height: 16),
                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    maxRating: 5,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 40.0,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) async {
                                      ratingValue = rating.toInt();
                                      print('Selected rating: ');
                                    },
                                  ),
                                ],
                              ),
                              onConfirm: () async {
                                if (ratingValue != 0)
                                  await controllerRating.addRating(
                                      'ratings', ratingValue);
                                Get.back();
                                Get.snackbar(
                                  "Berhasil",
                                  "Terimakasih sudah menilai",
                                  backgroundColor: Colors.white,
                                  icon: const Icon(Icons.check,
                                      color: Colors.green),
                                );
                              },
                              textConfirm: "Okay",
                              textCancel: "cancel");
                        },
                        child: const Text("Tambah rating "),
                      ),
                    if (controllerRating.isLoading
                        .value) // Tampilkan indikator loading jika isLoading true
                      const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              // Panjang indentasi awal garis
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text("Rating Perusahaan :",
                  style: GoogleFonts.oswald(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.0)),
            ),
            GetBuilder<RatingDialogController>(
                init: controllerRating,
                builder: (controller) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
                              child: RatingBar.builder(
                                initialRating:
                                    controllerRating.averageRating.value,
                                tapOnlyMode: true,
                                ignoreGestures: true,
                                minRating: 1,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 30.0,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) async {
                                  ratingValue = rating.toInt();
                                  print('Selected rating: ');
                                },
                              ),
                            )),
                      ],
                    ),
                  );
                }),
            const Divider(
              color: Colors.black,
              thickness: 1,
              // Panjang indentasi awal garis
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text("Deskripsi Perusahaan :",
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.0)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
              child: Text(
                tempat.detailPt,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              // Panjang indentasi awal garis
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text("Program Studi yang dibutuhkan : ",
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.0)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
              child: Text(
                tempat.jurusanPt,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              // Panjang indentasi awal garis
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text("Jumlah mahasiswa yang dibutuhkan : ",
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.0)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
              child: Text(
                tempat.ketentuanPt,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              // Panjang indentasi awal garis
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text("Berkas-berkas yang diperlukan : ",
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.0)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
              child: Text(
                tempat.syaratPt,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              // Panjang indentasi awal garis
              endIndent: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
                  child: Text("Share foto pengalaman mu disini",
                      style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.0)),
                ),
                IconButton(
                  onPressed: () {
                    controller.ambilFoto();
                  },
                  icon: const Icon(
                    Icons.photo_camera,
                    size: 30,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamMedia(tempat.namaPt),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('BELUM ADA FOTO'),
                    ),
                  );
                }
                // if (snapshot.data!.docs.isEmpty) {
                //   return const Center(
                //     child: Text('BELUM ADA FOTO'),
                //   );
                // }
                //ambil data foto di controller
                List<MediaModel> allFotouser = [];
                for (var element in snapshot.data!.docs) {
                  allFotouser.add(MediaModel.fromJson(element.data()));
                }

                return Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: allFotouser.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      MediaModel foto = allFotouser[index];
                      return Container(
                        height: 500,
                        width: 300,
                        margin: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          image: DecorationImage(
                            image: NetworkImage(
                              '${foto.fotoUser}',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: PhotoView(
                                        imageProvider:
                                            NetworkImage(foto.fotoUser),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: controller.streamRole(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                String role = snapshot.data!.data()!["role"];
                                if (role == "admin") {
                                  return Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () async {
                                        if (!controller.isDeleting.value) {
                                          // Set status loading
                                          controller.isDeleting.value = true;

                                          // Hapus gambar
                                          await controller.hapusGambar(
                                            foto.id,
                                            foto.fotoUser,
                                          );

                                          // Reset status loading
                                          controller.isDeleting.value = false;
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.streamRole(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  String role = snapshot.data!.data()!["role"];
                  if (role == "admin") {
                    return Center(
                      child: TextButton.icon(
                          onPressed: () {
                            Get.toNamed(Routes.UPDATE_DATA, arguments: tempat);
                          },
                          icon: Icon(Icons.update),
                          label: Text("Update data")),
                    );
                  }
                  return SizedBox();
                }),
            const SizedBox(height: 20),
          ]),
        ));
  }
}
