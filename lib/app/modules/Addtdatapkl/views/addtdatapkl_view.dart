import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/addtdatapkl_controller.dart';

class AddtdatapklView extends GetView<AddtdatapklController> {
  const AddtdatapklView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF000080),
          title: const Text('Tambah perusahaan'),
          centerTitle: true,
        ),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          TextField(
            autocorrect: false,
            controller: controller.namapC,
            decoration: InputDecoration(
              labelText: "Nama Perusahaan",
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
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: controller.namatC,
            decoration: InputDecoration(
              labelText: "Nama Lengkap Perusahaan",
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
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: controller.detailC,
            decoration: InputDecoration(
              labelText: "Deskripsi perusahaan",
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
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: controller.ketenC,
            decoration: InputDecoration(
              labelText: "Jumlah Mahasiswa ",
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
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: controller.jurusanC,
            decoration: InputDecoration(
              labelText: "Jurusan yang diminta",
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
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: controller.alamatC,
            decoration: InputDecoration(
              labelText: "Alamat Perusahaan",
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
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: controller.emailpC,
            decoration: InputDecoration(
              labelText: "Email Perusahaan",
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
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: controller.syaratC,
            decoration: InputDecoration(
              labelText: "Syarat Perusahaan",
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<AddtdatapklController>(builder: (c) {
                if (c.image != null) {
                  return Container(
                    height: 100,
                    width: 100,
                    child: Image.file(File(c.image!.path), fit: BoxFit.cover),
                  );
                } else {
                  return const Text("data image belum masuk");
                }
              }),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: const Text("Upload Logo Perusahaan"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => controller.addTempat(
                    controller.namapC.text,
                    controller.namatC.text,
                    controller.detailC.text,
                    controller.ketenC.text,
                    controller.jurusanC.text,
                    controller.alamatC.text,
                    controller.emailpC.text,
                    controller.syaratC.text,
                  ),
              // ignore: sort_child_properties_last
              child: Obx(() => Text(
                    controller.isloading.isFalse ? "Tambah data" : "Loading...",
                  )),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF000080)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )))),
        ]));
  }
}
