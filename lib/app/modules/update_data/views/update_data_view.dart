import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infopkl/app/data/models/modeldata.dart';

import '../controllers/update_data_controller.dart';

class UpdateDataView extends GetView<UpdateDataController> {
  // UpdateDataView({Key? key}) : super(key: key);
  final TempatModel tempat = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.namapC.text = tempat.namaPt;
    controller.namatC.text = tempat.namaterang;
    controller.detailC.text = tempat.detailPt;
    controller.ketenC.text = tempat.ketentuanPt;
    controller.jurusanC.text = tempat.jurusanPt;
    controller.alamatC.text = tempat.alamatPt;
    controller.emailpC.text = tempat.emailPt;
    controller.syaratC.text = tempat.syaratPt;
    controller.fotoC.text = tempat.fotoPt;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Update data'),
          centerTitle: true,
          backgroundColor: const Color(0xFF000080),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          // const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     GetBuilder<AddtdatapklController>(builder: (c) {
          //       if (c.image != null) {
          //         return Container(
          //           height: 100,
          //           width: 100,
          //           child: Image.file(File(c.image!.path), fit: BoxFit.cover),
          //         );
          //       } else {
          //         return const Text("data image belum masuk");
          //       }
          //     }),
          //     TextButton(
          //       onPressed: () {
          //         controller.pickImage();
          //       },
          //       child: const Text("Upload Logo Perusahaan"),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isloading.isFalse) {
                    controller.updateData(tempat.namaPt);
                  }
                },
                child: Text(
                    controller.isloading.isFalse ? "Update data" : "Loading...",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF000080)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
              ),
            ),
          )
        ]));
  }
}
