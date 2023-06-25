import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infopkl/app/routes/app_pages.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "SELAMAT DATANG",
          body:
              "Segala Informasi Tempat PKL Tersedia disini! , Jika sudah pernah Login skip proses ini",
          image: SizedBox(
            width: Get.width * 6,
            height: Get.width * 6,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/slide5.svg',
                width: 300,
                height: 250,
              ),
            ),
          ),
          decoration: const PageDecoration(
            pageColor: Colors.white70,
            titleTextStyle: TextStyle(
              fontSize: 23,
              color: Colors.black, // Ubah warna font di sini
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.black, // Ubah warna font di sini
            ),
          ),
        ),
        PageViewModel(
          title: "Semua yang kamu butuhkan ada di ujung jarimu !",
          body:
              "Dapatkan rekomendasi Tempat PKL yang relevan dengan bidangmu serta profilmu hanya dalam satu sentuhan",
          image: SizedBox(
            width: Get.width * 6,
            height: Get.width * 6,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/slide2.svg',
                width: 300,
                height: 250,
              ),
            ),
          ),
          decoration: const PageDecoration(
            pageColor: Color(0xFF000080),
            titleTextStyle: TextStyle(
              fontSize: 23,
              color: Colors.white, // Ubah warna font di sini
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.white, // Ubah warna font di sini
            ),
          ),
        ),
        PageViewModel(
          title: "PERHATIAN !",
          body:
              "Aplikasi Ini terintegrasi dengan siakad.pnm.ac.id, Bagi Mahsiswa Aktif Politeknik Negeri Madiun silahkan login dengan email yang sudah terdaftar di siakad",
          image: SizedBox(
            width: Get.width * 6,
            height: Get.width * 6,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/slide3.svg',
                width: 300,
                height: 250,
              ),
            ),
          ),
          decoration: const PageDecoration(
            pageColor: Colors.white70,
            titleTextStyle: TextStyle(
              fontSize: 23,
              color: Colors.black, // Ubah warna font di sini
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.black, // Ubah warna font di sini
            ),
          ),
        ),
        // PageViewModel(
        //   title: "PERHATIAN !",
        //   body:
        //       "Aplikasi Ini terintegrasi dengan siakad.pnm.ac.id, Bagi Mahsiswa Aktif Politeknik Negeri Madiun silahkan login dengan email yang sudah terdaftar di siakad",
        //   image: Container(
        //     width: Get.width * 6,
        //     height: Get.width * 6,
        //     child: Center(
        //       child: SvgPicture.asset('assets/images/slide3.svg',
        //           width: 300, height: 250),
        //     ),
        //   ),
        // ),
        PageViewModel(
          title: "PERLU DIPERHATIKAN!",
          body:
              "Bagi Mahasiswa yang baru pertama login, silahkan login dengan email siakad kamu dan password default : 'password'",
          image: Center(
            child: SvgPicture.asset(
              'assets/images/slide4.svg',
              width: 280,
              height: 250,
            ),
          ),
          decoration: const PageDecoration(
            pageColor: Color(0xFF000080),
            titleTextStyle: TextStyle(
              fontSize: 23,
              color: Colors.white, // Ubah warna font di sini
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.white, // Ubah warna font di sini
            ),
          ),
        )
      ],
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.bold)),
      next: const Text("Next", style: TextStyle(fontWeight: FontWeight.bold)),
      done: const Text("Login", style: TextStyle(fontWeight: FontWeight.w700)),
      onDone: () {
        Get.offAllNamed(Routes.LOGIN);
      },
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Theme.of(context).colorScheme.secondary,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    ));
  }
}
