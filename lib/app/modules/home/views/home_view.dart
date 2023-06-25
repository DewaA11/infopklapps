import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import '../../../data/models/modeldata.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../../controllers/page_index_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  final pageC = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();
    List<TempatModel> allTempatMain = [];
    var allTempat = <TempatModel>[].obs;

    onSearch(String key) {
      if (key.isEmpty) {
        // Jika key kosong, tampilkan semua data yang ada
        allTempat.value = allTempatMain.toList();
      } else {
        allTempat.value = allTempatMain
            .where((data) => data.namaPt
                .toString()
                .toLowerCase()
                .contains(key.toString().toLowerCase()))
            .toList();
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: const Color(0xFF000080),
          title: const Text('HOME'),
          centerTitle: true,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                controller: searchC,
                onChanged: (value) => onSearch(value),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  hintText: "Search",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  suffixIcon: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {},
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(135),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamTempat(),
          builder: (context, snapTempat) {
            if (snapTempat.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapTempat.data!.docs.isEmpty && allTempat.isEmpty) {
              return const Center(
                child: Text('TIDAK ADA DATA'),
              );
            }

            allTempatMain
                .clear(); // Reset allTempatMain sebelum mengisi ulang data
            for (var element in snapTempat.data!.docs) {
              allTempatMain.add(TempatModel.fromJson(element.data()));
            }

            controller.allTempat
                .removeWhere((data) => !allTempatMain.contains(data));
            controller.allTempat.refresh();

            allTempat.value = allTempatMain
                .where((data) =>
                    data.namaPt.toString().toLowerCase().contains(searchC.text))
                .toList();

            return Obx(() {
              if (allTempat.isEmpty) {
                return const Center(
                  child: Text('TIDAK ADA DATA'),
                );
              } else {
                return ListView.builder(
                  itemCount: allTempat.length,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    TempatModel tempat = allTempat[index];
                    return Card(
                      elevation: 10,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 405,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tempat.namaPt,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  // SizedBox(height: 10),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    // Panjang indentasi awal garis
                                    endIndent: 0,
                                  ),
                                  Container(
                                    height: 125,
                                    width: 500,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${tempat.fotoPt}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 18,
                                        backgroundColor:
                                            const Color(0xFF000080),
                                        child: Icon(
                                          Icons.account_balance,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5, left: 5),
                                          child: Text(
                                            tempat.namaterang,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Row(children: [
                                    const CircleAvatar(
                                      radius: 18,
                                      backgroundColor: const Color(0xFF000080),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.find<HomeController>()
                                              .launchMap(tempat.alamatPt);
                                        },
                                        child: Text(
                                          tempat.alamatPt,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 18,
                                        backgroundColor:
                                            const Color(0xFF000080),
                                        child: Icon(
                                          Icons.email,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        child: Text(
                                          tempat.emailPt,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 5),
                                  StreamBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: controller.streamRole(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const SizedBox();
                                      }
                                      String role =
                                          snapshot.data!.data()!["role"];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (role == "admin")
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Get.defaultDialog(
                                                      title: "Delete data",
                                                      middleText:
                                                          "Apakah anda yakin akan menghapus data?",
                                                      actions: [
                                                        OutlinedButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: const Text(
                                                              "CANCEL"),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            controller.delete(
                                                                tempat.namaPt);
                                                            allTempat.removeAt(
                                                                index);
                                                            controller
                                                                .isLoadingDelete(
                                                                    true);
                                                            controller.delete(
                                                                tempat.namaPt);
                                                            controller
                                                                .isLoadingDelete(
                                                                    false);
                                                            //balik ke page all data
                                                            Get.back();
                                                            Get.back();
                                                          },
                                                          child: Obx(() => controller
                                                                  .isLoadingDelete
                                                                  .isFalse
                                                              ? const Text(
                                                                  "Hapus Data")
                                                              : Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(1),
                                                                  height: 12,
                                                                  width: 10,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500,
                                                                  ),
                                                                )),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  color: Colors.red.shade700,
                                                ),
                                                const SizedBox(width: 10),
                                                TextButton(
                                                  onPressed: () {
                                                    Get.toNamed(
                                                        Routes.HASILRATING,
                                                        arguments: tempat);
                                                  },
                                                  child: const Text(
                                                      'Lihat Rating'),
                                                ),
                                              ],
                                            ),
                                          const Spacer(), // Menambahkan Spacer untuk mengisi ruang kosong
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.toNamed(Routes.DETAIL_PKL,
                                                  arguments: tempat);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color(0xFF000080)),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                            ),
                                            child: const Text("Lihat Detail"),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            });
          }),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: const Color(0xFF000080),
        currentIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
        items: const [
          BottomNavigationBarItem(icon: Icon(FontAwesome.home)),
          BottomNavigationBarItem(icon: Icon(FontAwesome.envelope)),
          BottomNavigationBarItem(icon: Icon(FontAwesome.user)),
        ],
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        iconSize: 28,
      ),
      // bottomNavigationBar: ConvexAppBar(
      //   items: const [
      //     TabItem(icon: Icons.home, title: 'Home'),
      //     TabItem(icon: Icons.mail, title: 'Kuesioner'),
      //     TabItem(icon: Icons.people, title: 'Profile'),
      //   ],
      //   backgroundColor: const Color(0xFF000080),
      //   initialActiveIndex: pageC.pageIndex.value,
      //   onTap: (int i) => pageC.changePage(i),
      //   height: 50,
      //   curveSize: 20,
      // ),
    );
  }
}
