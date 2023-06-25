import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/update_profil_controller.dart';

class UpdateProfilView extends GetView<UpdateProfilController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.npmC.text = user['npm'];
    controller.nameC.text = user['name'];
    controller.emailC.text = user['email'];
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50),
            const Center(
              child: Text("Update Profil",
                  style: TextStyle(
                      color: Color(0xFF000080),
                      fontSize: 40,
                      fontWeight: FontWeight.w900)),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset(
                      'assets/images/Untukprofil.svg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              readOnly: true,
              autocorrect: false,
              controller: controller.npmC,
              decoration: InputDecoration(
                hintText: 'Masukkan npm',
                hintStyle: const TextStyle(color: Colors.black),
                labelText: "Masukkan npm",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 15),
            TextField(
              readOnly: true,
              autocorrect: false,
              controller: controller.emailC,
              decoration: InputDecoration(
                hintText: 'Masukkan email',
                hintStyle: const TextStyle(color: Colors.black),
                labelText: "Masukkan Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 15),
            TextField(
              autocorrect: false,
              controller: controller.nameC,
              decoration: InputDecoration(
                hintText: 'Masukkan nama',
                hintStyle: const TextStyle(color: Colors.black),
                labelText: "Masukkan Nama",
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text("Photo Profile",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<UpdateProfilController>(
                  builder: (c) {
                    if (c.image != null) {
                      return ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.file(File(c.image!.path),
                              fit: BoxFit.cover),
                        ),
                      );
                    } else {
                      if (user['profile'] != null) {
                        return ClipOval(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(user['profile'],
                                fit: BoxFit.cover),
                          ),
                        );
                      } else {
                        return const Text("No image");
                      }
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: const Text("choosee"),
                ),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                      onPressed: () async {
                        if (controller.isloading.isFalse) {
                           controller.updateProfile(user["uid"]);
                        }
                      },
                      child: Text(
                          controller.isloading.isFalse
                              ? "Update profil"
                              : "Loading...",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(const Color(0xFF000080)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                    ),
                    ),
                    ),
          ]),
        ),
      ),
    );
  }
}
