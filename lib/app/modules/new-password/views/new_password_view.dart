import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 80),
          const Center(
            child: Text("Password Baru",
                style: TextStyle(
                    color: Color(0xFF000080),
                    fontSize: 40,
                    fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 80),
          SvgPicture.asset(
            'assets/images/Untuk Reset.svg',
            width: 280,
            height: 300,
          ),
          const SizedBox(height: 50),
          Obx(() => TextField(
                maxLength: 16,
                autocorrect: false,
                controller: controller.newPassC,
                obscureText: controller.isPasswordHidden.value,
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
                  hintText: 'Masukkan Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelText: "Masukkan password",
                  labelStyle: const TextStyle(color: Colors.black),
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
                ),
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
              )),
          const SizedBox(height: 40),
          SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.newPassword();
                },
                child: const Text('CONTINUE',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF000080)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
              ))
        ]),
      ),
    ));
  }
}
