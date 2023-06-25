import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:infopkl/app/modules/kuesioner_hasil/views/kuesioner_hasil_view.dart';
import '../controllers/kuesioner_controller.dart';
import '../../../controllers/page_index_controller.dart';

class KuesionerView extends GetView<KuesionerController> {
  final pageC = Get.find<PageIndexController>();
  final KuesionerController _questionnaireController =
      Get.put(KuesionerController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KUESIONER'),
        centerTitle: true,
        backgroundColor: const Color(0xFF000080),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              SvgPicture.asset(
                'assets/images/kuesioner.svg',
                width: 280,
                height: 300,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _answerController,
                decoration: InputDecoration(
                  labelText: 'Saran dan kritik',
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Saran dan kritik harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Mengumpulkan data kuesioner
                    Map<String, dynamic> questionnaireData = {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'answer': _answerController.text,
                    };

                    // Submit kuesioner
                    _questionnaireController
                        .submitQuestionnaire(questionnaireData);

                    _nameController.clear();
                    _emailController.clear();
                    _answerController.clear();
                  }
                },
                // ignore: sort_child_properties_last
                child: const Text('KIRIM'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF000080)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
                  fixedSize: MaterialStateProperty.all(Size(400, 50)),
                ),
              ),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller.streamRole(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    String role = snapshot.data!.data()!["role"];
                    if (role == "admin") {
                      return TextButton(
                        onPressed: () {
                          Get.to(KuesionerHasilView());
                        },
                        child: const Text("Lihat hasil Kuesioner"),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            ],
          ),
        ),
      ),
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


// class KuesionerView extends GetView<KuesionerController> {
//   final pageC = Get.find<PageIndexController>();
//   final KuesionerController _questionnaireController =
//       Get.put(KuesionerController());

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _answerController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('KUESIONER'),
//         centerTitle: true,
//         backgroundColor: Color(0xFF000080),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               SizedBox(height: 10),
//               SvgPicture.asset(
//                 'assets/images/kuesioner.svg',
//                 width: 280,
//                 height: 300,
//               ),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Nama',
//                   labelStyle: TextStyle(color: Colors.black),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                 ),
//                 style: const TextStyle(fontSize: 16.0, color: Colors.black),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Nama harus diisi';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: TextStyle(color: Colors.black),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                 ),
//                 style: const TextStyle(fontSize: 16.0, color: Colors.black),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Email harus diisi';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _answerController,
//                 decoration: InputDecoration(
//                   labelText: 'Saran dan kritik',
//                   labelStyle: TextStyle(color: Colors.black),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40),
//                     borderSide: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                 ),
//                 style: const TextStyle(fontSize: 16.0, color: Colors.black),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Saran dan kritik harus diisi';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Mengumpulkan data kuesioner
//                     Map<String, dynamic> questionnaireData = {
//                       'name': _nameController.text,
//                       'age': _emailController.text,
//                       'answer': _answerController.text,
//                     };

//                     // Submit kuesioner
//                     _questionnaireController
//                         .submitQuestionnaire(questionnaireData);
//                   }
//                 },
//                 child: Text('Submit'),
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(Color(0xFF000080)),
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ))),
//               ),
//               TextButton(onPressed: () {}, child: Text("Lihat hasil Kuesioner"))
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: ConvexAppBar(
//         items: [
//           TabItem(icon: Icons.home, title: 'Home'),
//           TabItem(icon: Icons.mail, title: 'Kuesioner'),
//           TabItem(icon: Icons.people, title: 'Profile'),
//         ],
//         initialActiveIndex: pageC.pageIndex.value,
//         onTap: (int i) => pageC.changePage(i),
//         backgroundColor: Color(0xFF000080),
//         height: 50,
//         curveSize: 20,
//       ),
//     );
//   }
// }
