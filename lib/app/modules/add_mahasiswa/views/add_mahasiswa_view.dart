import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/add_mahasiswa_controller.dart';

class AddMahasiswaView extends GetView<AddMahasiswaController> {
  const AddMahasiswaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add mahasiswa'),
        centerTitle: true,
        backgroundColor: const Color(0xFF000080),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SvgPicture.asset(
            'assets/images/untukp.svg',
            width: 280,
            height: 300,
          ),
          TextField(
            autocorrect: false,
            controller: controller.npmC,
            decoration: InputDecoration(
              labelText: "NPM",
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
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.namaC,
            decoration: InputDecoration(
              labelText: "Nama Mahasiswa",
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
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
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
          ),
          const SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  controller.addmahasiswa();
                }
              },
              // ignore: sort_child_properties_last
              child:
                  Text(controller.isLoading.isFalse ? "TAMBAH" : "LOADING..."),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF000080)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                )),
                fixedSize: MaterialStateProperty.all(Size(200, 50)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
