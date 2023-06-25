import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50),
            const Center(
              child: Text("Update Password",
                  style: TextStyle(
                      color: Color(0xFF000080),
                      fontSize: 40,
                      fontWeight: FontWeight.w900)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      'assets/images/Gantipassgif.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Obx(() => TextField(
                  autocorrect: false,
                  controller: controller.currC,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    hintText: 'Masukkan Password lama',
                    suffix: InkWell(
                      child: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                          size: 24),
                      onTap: () {
                        controller.isPasswordHidden.value =
                            !controller.isPasswordHidden.value;
                      },
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    labelText: "Password lama",
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                )),
            const SizedBox(height: 15),
            Obx(() => TextField(
                  autocorrect: false,
                  maxLength: 16,
                  controller: controller.newC,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    hintText: 'Masukkan Password Baru',
                    suffix: InkWell(
                      child: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                          size: 24),
                      onTap: () {
                        controller.isPasswordHidden.value =
                            !controller.isPasswordHidden.value;
                      },
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    labelText: "Password baru",
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                )),
            const SizedBox(height: 15),
            Obx(() => TextField(
                  autocorrect: false,
                  maxLength: 16,
                  controller: controller.confirmC,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    hintText: 'Ulangi Password',
                    suffix: InkWell(
                      child: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                          size: 24),
                      onTap: () {
                        controller.isPasswordHidden.value =
                            !controller.isPasswordHidden.value;
                      },
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    labelText: "Ulangi password baru",
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                )),
            const SizedBox(height: 20),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                      onPressed: () {
                        if (controller.isLoading.isFalse) {
                          if (controller.newC.text.length < 8) {
                            // Tampilkan alert jika password tidak memenuhi persyaratan
                            Get.snackbar(
                              'Peringatan',
                              'Password harus terdiri dari minimal 8 karakter!',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            controller.updatePass();
                          }
                        }
                      },
                      // ignore: sort_child_properties_last
                      child: Text(
                          controller.isLoading.isFalse
                              ? "Ganti password"
                              : "LOADING....",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF000080)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                    )))
          ]),
        ),
      ),
    );
  }
}

// class UpdatePasswordView extends GetView<UpdatePasswordController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             SizedBox(height: 50),
//             Center(
//               child: Text("Update Password",
//                   style: TextStyle(
//                       color: Color(0xFF000080),
//                       fontSize: 40,
//                       fontWeight: FontWeight.w900)),
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ClipOval(
//                   child: Container(
//                     width: 300,
//                     height: 300,
//                     child: Image.asset(
//                       'assets/images/Gantipassgif.gif',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 50),
//             Obx(() => TextField(
//                   autocorrect: false,
//                   controller: controller.currC,
//                   obscureText: controller.isPasswordHidden.value,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(40),
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(40),
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                     hintText: 'Masukkan Password lama',
//                     suffix: InkWell(
//                       child: Icon(
//                           controller.isPasswordHidden.value
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Colors.grey,
//                           size: 24),
//                       onTap: () {
//                         controller.isPasswordHidden.value =
//                             !controller.isPasswordHidden.value;
//                       },
//                     ),
//                     hintStyle: TextStyle(color: Colors.black),
//                     labelText: "Password lama",
//                     labelStyle: TextStyle(color: Colors.black),
//                   ),
//                   style: const TextStyle(fontSize: 16.0, color: Colors.black),
//                 )),
//             SizedBox(height: 15),
//             Obx(() => TextField(
//                   autocorrect: false,
//                   maxLength: 8,
//                   controller: controller.newC,
//                   obscureText: controller.isPasswordHidden.value,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(40),
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(40),
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                     hintText: 'Masukkan Password Baru',
//                     suffix: InkWell(
//                       child: Icon(
//                           controller.isPasswordHidden.value
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Colors.grey,
//                           size: 24),
//                       onTap: () {
//                         controller.isPasswordHidden.value =
//                             !controller.isPasswordHidden.value;
//                       },
//                     ),
//                     hintStyle: TextStyle(color: Colors.black),
//                     labelText: "Password baru",
//                     labelStyle: TextStyle(color: Colors.black),
//                   ),
//                   style: const TextStyle(fontSize: 16.0, color: Colors.black),
//                 )),
//             SizedBox(height: 15),
//             Obx(() => TextField(
//                   autocorrect: false,
//                   maxLength: 8,
//                   controller: controller.confirmC,
//                   obscureText: controller.isPasswordHidden.value,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(40),
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(40),
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                     hintText: 'Ulangi Password',
//                     suffix: InkWell(
//                       child: Icon(
//                           controller.isPasswordHidden.value
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Colors.grey,
//                           size: 24),
//                       onTap: () {
//                         controller.isPasswordHidden.value =
//                             !controller.isPasswordHidden.value;
//                       },
//                     ),
//                     hintStyle: TextStyle(color: Colors.black),
//                     labelText: "Ulangi password baru",
//                     labelStyle: TextStyle(color: Colors.black),
//                   ),
//                   style: const TextStyle(fontSize: 16.0, color: Colors.black),
//                 )),
//             SizedBox(height: 40),
//             SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: Obx(() => ElevatedButton(
//                       onPressed: () {
//                         if (controller.isLoading.isFalse) {
//                           controller.updatePass();
//                         }
//                       },
//                       child: Text(
//                           controller.isLoading.isFalse
//                               ? "Ganti password"
//                               : "LOADING....",
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold)),
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Color(0xFF000080)),
//                           shape:
//                               MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ))),
//                     )))
//           ]),
//         ),
//       ),
//     );
//   }
// }
