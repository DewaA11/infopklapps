import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infopkl/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
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
          child: Text("LOGIN",
              style: TextStyle(
                  color: Color(0xFF000080),
                  fontSize: 40,
                  fontWeight: FontWeight.w900)),
        ),
        SvgPicture.asset(
          'assets/images/Untuklogin.svg',
          width: 280,
          height: 300,
        ),
        TextField(
          cursorColor: Colors.black,
          autocorrect: false,
          controller: controller.emailC,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Masukkan Email',
            hintStyle: const TextStyle(color: Colors.black),
            labelText: "Masukkan Email",
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
        const SizedBox(height: 30),
        Obx(() => TextField(
              maxLength: 16,
              autocorrect: false,
              controller: controller.passC,
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
        const SizedBox(height: 30),
        SizedBox(
            height: 50,
            width: double.infinity,
            child: Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      controller.login();
                    }
                  },
                  child: Text(
                      controller.isLoading.isFalse ? "LOGIN" : "Loading...",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF000080)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                ))),
        TextButton(
            onPressed: () => Get.toNamed(Routes.LUPA_PASSWORD),
            child: const Text("Lupa Password?")),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Belum Punya akun?"),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("PESAN EMAIL",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        content: const Text(
                            "isikan email aktif anda, nim, dan nama lengkap"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Batal"),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.sendEmailToAdmin();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Lanjut"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Hubungi Admin"),
              ),
            ],
          ),
        ),
      ])),
    ));
  }
}
