import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infopkl/app/routes/app_pages.dart';
import 'package:photo_view/photo_view.dart';
import '../controllers/profil_controller.dart';
import '../../../controllers/page_index_controller.dart';

class ProfilView extends GetView<ProfilController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
        centerTitle: true,
        backgroundColor: const Color(0xFF000080),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasData) {
              Map<String, dynamic> user = snap.data!.data()!;
              String defaultImage =
                  "https://ui-avatars.com/api/?name=${user['name']}";
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Card(
                    color: Colors.grey.shade200,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: const Color(0xFF000080),
                                    title: const Text('Foto Profil'),
                                    leading: IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Kembali ke layar sebelumnya
                                      },
                                    ),
                                  ),
                                  body: PhotoView(
                                    imageProvider: NetworkImage(
                                      user["profile"] != null &&
                                              user["profile"] != ""
                                          ? user["profile"]
                                          : defaultImage,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                user["profile"] != null && user["profile"] != ""
                                    ? user["profile"]
                                    : defaultImage,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${user['name'].toString().toUpperCase()}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${user['npm'].toString().toUpperCase()}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text("Account",
                      style: GoogleFonts.oswald(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.5)),
                  const SizedBox(height: 15),
                  InkWell(
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        onTap: () => Get.toNamed(
                          Routes.UPDATE_PROFIL,
                          arguments: user,
                        ),
                        leading: const Icon(Icons.person_2),
                        title: const Text("Update Profil"),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                        leading: const Icon(Icons.vpn_key),
                        title: const Text("Update Password"),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () =>
                            controller.showLogoutConfirmationDialog(context),
                        leading: const Icon(Icons.logout_rounded),
                        title: const Text("Logout"),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   child: Card(
                  //     margin: const EdgeInsets.only(bottom: 10),
                  //     color: Colors.grey.shade200,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: ListTile(
                  //       onTap: () => controller.logout(),
                  //       leading: const Icon(Icons.logout_rounded),
                  //       title: const Text("Logout"),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 7),
                  if (user["role"] == "admin")
                    Text("Setting",
                        style: GoogleFonts.oswald(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1.5)),
                  const SizedBox(height: 7),
                  if (user["role"] == "admin")
                    InkWell(
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          onTap: () => Get.toNamed(Routes.ADD_MAHASISWA),
                          leading: const Icon(Icons.person_add),
                          title: const Text("Add mahasiswa"),
                        ),
                      ),
                    ),
                  if (user["role"] == "admin")
                    InkWell(
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          onTap: () => Get.toNamed(Routes.ADDTDATAPKL),
                          leading: const Icon(Icons.add_box),
                          title: const Text("Add Tempat PKL"),
                        ),
                      ),
                    ),
                ],
              );
            } else {
              return const Center(child: Text("Tidak dapat memuat data user"));
            }
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
    );
  }
}
