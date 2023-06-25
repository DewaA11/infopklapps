import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lupa_password_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Color(0xFF000080),
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/untuklupapass.svg',
                width: 280,
                height: 300,
              ),
              const SizedBox(height: 50),
              TextField(
                autocorrect: false,
                controller: controller.emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
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
                  hintText: 'Masukkan Email',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelText: "Masukkan Email",
                  labelStyle: const TextStyle(color: Colors.black),
                ),
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              const SizedBox(height: 40),
              // Obx(() => TextField(
              //       autocorrect: false,
              //       controller: controller.passwordC,
              //       obscureText: controller.isPasswordHidden.value,
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(40),
              //           borderSide: BorderSide(color: Colors.black, width: 2),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(40),
              //           borderSide: BorderSide(color: Colors.black, width: 2),
              //         ),
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              //         hintText: 'Masukkan Password Baru',
              //         suffixIcon: InkWell(
              //           child: Icon(
              //             controller.isPasswordHidden.value
              //                 ? Icons.visibility
              //                 : Icons.visibility_off,
              //             color: Colors.grey,
              //             size: 24,
              //           ),
              //           onTap: () {
              //             controller.isPasswordHidden.value =
              //                 !controller.isPasswordHidden.value;
              //           },
              //         ),
              //         hintStyle: TextStyle(color: Colors.black),
              //         labelText: "Password Barru",
              //         labelStyle: TextStyle(color: Colors.black),
              //       ),
              //       style: const TextStyle(fontSize: 16.0, color: Colors.black),
              //     )),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                      onPressed: () {
                        if (!controller.IsLoading.value) {
                          controller.sendEmail();
                        }
                      },
                      child: Text(
                        controller.IsLoading.value
                            ? "Loading..."
                            : "Forgot Password",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF000080)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class LupaPasswordView extends GetView<LupaPasswordController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             SizedBox(height: 100),
//             Center(
//               child: Text("Forgot Password",
//                   style: TextStyle(
//                       color: Color(0xFF000080),
//                       fontSize: 40,
//                       fontWeight: FontWeight.w900)),
//             ),
//             SvgPicture.asset(
//               'assets/images/untuklupapass.svg',
//               width: 280,
//               height: 300,
//             ),
//             SizedBox(height: 50),
//             TextField(
//               autocorrect: false,
//               controller: controller.emailC,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(40),
//                   borderSide: BorderSide(color: Colors.black, width: 2),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(40),
//                   borderSide: BorderSide(color: Colors.black, width: 2),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                 hintText: 'Masukkan Email',
//                 hintStyle: TextStyle(color: Colors.black),
//                 labelText: "Masukkan Email",
//                 labelStyle: TextStyle(color: Colors.black),
//               ),
//               style: const TextStyle(fontSize: 16.0, color: Colors.black),
//             ),
//             SizedBox(height: 40),
//             Obx(() => TextField(
//                   autocorrect: false,
//                   controller: controller.passwordC,
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
//                     labelText: "Password lama",
//                     labelStyle: TextStyle(color: Colors.black),
//                   ),
//                   style: const TextStyle(fontSize: 16.0, color: Colors.black),
//                 )),
//             SizedBox(height: 30),
//             SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: Obx(() => ElevatedButton(
//                       onPressed: () {
//                         if (controller.IsLoading.isFalse) {
//                           controller.sendEmail();
//                         }
//                       },
//                       child: Text(
//                           controller.IsLoading.isFalse
//                               ? "Forgot Password"
//                               : "Loading...",
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold)),
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Color(0xFF000080)),
//                           shape:
//                               MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ))),
//                       // style: ElevatedButton.styleFrom(
//                       //     primary: Color(0xFF000080),
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(10),
//                       //     )),
//                     )))
//           ]),
//         ),
//       ),
//     );
//   }
// }
