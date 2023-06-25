import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kuesioner_hasil_controller.dart';

class KuesionerHasilView extends GetView<KuesionerHasilController> {
  // ignore: unused_field
  final KuesionerHasilController _questionnaireController =
      Get.put(KuesionerHasilController());
  KuesionerHasilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuesioner'),
        centerTitle: true,
        backgroundColor: const Color(0xFF000080),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi Hapus'),
                  content:
                      const Text('Apakah Anda yakin ingin menghapus data ini?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup dialog konfirmasi
                        controller.deleteAllkuesioner();
                      },
                      child: const Text('Hapus'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pop(), // Tutup dialog konfirmasi
                      child: const Text('Batal'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.kuesionerhasil(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final questionnaires = snapshot.data!.docs;
              return ListView.builder(
                itemCount: questionnaires.length,
                itemBuilder: (context, index) {
                  final questionnaireData = questionnaires[index].data();
                  return Card(
                    child: ListTile(
                      title: Text('Nama: ${questionnaireData['name']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${questionnaireData['email']}'),
                          Text('Jawaban: ${questionnaireData['answer']}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Terjadi kesalahan');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
