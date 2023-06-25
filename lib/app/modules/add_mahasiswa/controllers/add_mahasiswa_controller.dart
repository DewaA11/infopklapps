import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_pages.dart';

// import '../../../routes/app_pages.dart';

class AddMahasiswaController extends GetxController {
  final RxBool isLoading = false.obs;
  RxBool isPasswordValid = false.obs;
  final RxBool isPasswordHidden = true.obs;
  // var isPasswordHidden = true.obs;
  RxBool isLoadingAddMahasiswa = false.obs;
  TextEditingController namaC = TextEditingController();
  TextEditingController npmC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesaddmahasiswa() async {
    if (passAdminC.text.isNotEmpty) {
      try {
        // //loading
        isLoading.value = true;

        String emailAdmin = auth.currentUser!.email!;

        // ignore: unused_local_variable
        UserCredential userCredentialadmin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passAdminC.text);

        UserCredential mahasiswaCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: "password");

        if (mahasiswaCredential.user != null) {
          String? uid = mahasiswaCredential.user?.uid;

          firestore.collection("mahasiswa").doc(uid).set({
            "npm": npmC.text,
            "name": namaC.text,
            "email": emailC.text,
            "uid": uid,
            "role": "mahasiswa",
            "createAt": DateTime.now().toIso8601String(),
          });

          await mahasiswaCredential.user!.sendEmailVerification();

          await auth.signOut();

          // ignore: unused_local_variable
          UserCredential userCredentialadmin =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);

          Get.back();

          Get.snackbar(
            "Sukses",
            "Data mahasiswa berhasil disimpan",
            backgroundColor: Colors.white,
            icon: const Icon(Icons.check, color: Colors.green),
          );
          // Reset nilai input
          namaC.text = "";
          npmC.text = "";
          emailC.text = "";
          passAdminC.text = "";

          Get.offAllNamed(Routes.PROFIL);
        }

        // print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Error", "Password terlalu singkat",
              backgroundColor: Colors.white,
              icon: const Icon(Icons.close, color: Colors.red));
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Error", "Email sudah terdaftar",
              backgroundColor: Colors.white,
              icon: const Icon(Icons.close, color: Colors.red));
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Error", "Password admin salah",
              backgroundColor: Colors.white,
              icon: const Icon(Icons.close, color: Colors.red));
        } else {
          Get.snackbar("Terjadi kesalahan", "${e.code}",
              backgroundColor: Colors.white,
              icon: const Icon(Icons.close, color: Colors.red));
        }
      } catch (e) {
        Get.snackbar("Error", "Gagal menambahkan mahasiswa",
            backgroundColor: Colors.white,
            icon: const Icon(Icons.close, color: Colors.red));
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Error", "Password wajib diisi untuk validasi",
          backgroundColor: Colors.white,
          icon: const Icon(Icons.close, color: Colors.red));
    }
  }

  void addmahasiswa() async {
    if (namaC.text.isNotEmpty &&
        npmC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      Get.defaultDialog(
        title: "Validasi admin",
        content: Column(
          children: [
            const Text("Masukan Password validasi Admin"),
            const SizedBox(height: 10),
            Obx(() => TextField(
                  controller: passAdminC,
                  autocorrect: false,
                  obscureText: isPasswordHidden.value,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffix: InkWell(
                      child: Icon(
                        isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                        size: 24,
                      ),
                      onTap: () {
                        isPasswordHidden.toggle();
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                )),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: isLoading.value
                ? null
                : () async {
                    await prosesaddmahasiswa();
                  },
            child: isLoading.value
                ? Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text("TAMBAH"),
                    ],
                  )
                : const Text("TAMBAH"),
          ),
        ],
      );
    } else {
      Get.snackbar("Error", "Isian harus diisi",
          backgroundColor: Colors.white,
          icon: const Icon(Icons.close, color: Colors.red));
    }
    // void addmahasiswa() async {
    //   if (namaC.text.isNotEmpty &&
    //       npmC.text.isNotEmpty &&
    //       emailC.text.isNotEmpty) {
    //     Get.defaultDialog(
    //       title: "Validasai admin",
    //       content: Column(
    //         children: [
    //           const Text("Masukan Password validasi Admin"),
    //           const SizedBox(height: 10),
    //           Obx(() => TextField(
    //                 controller: passAdminC,
    //                 autocorrect: false,
    //                 obscureText: isPasswordHidden
    //                     .value, // Gunakan isPasswordHidden.value untuk mengatur obscureText
    //                 decoration: InputDecoration(
    //                   labelText: "Password",
    //                   suffix: InkWell(
    //                     child: Icon(
    //                       isPasswordHidden.value
    //                           ? Icons.visibility
    //                           : Icons.visibility_off,
    //                       color: Colors.grey,
    //                       size: 24,
    //                     ),
    //                     onTap: () {
    //                       isPasswordHidden
    //                           .toggle(); // Gunakan toggle() untuk membalik nilai RxBool
    //                     },
    //                   ),
    //                   border: const OutlineInputBorder(),
    //                 ),
    //               )),
    //         ],
    //       ),
    //       actions: [
    //         OutlinedButton(
    //           onPressed: () => Get.back(),
    //           child: const Text("CANCEL"),
    //         ),
    //         ElevatedButton(
    //           onPressed: isLoading.value
    //               ? null
    //               : () async {
    //                   await prosesaddmahasiswa();
    //                 },
    //           child:
    //               isLoading.value ? const CircularProgressIndicator() : const Text("TAMBAH"),
    //         ),
    //       ],
    //     );
    //   } else {
    //     Get.snackbar("Error", "Isian harus diisi",
    //         backgroundColor: Colors.white,
    //         icon: const Icon(Icons.close, color: Colors.red));
    //   }
    // }
  }
}
