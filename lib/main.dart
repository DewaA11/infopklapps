import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:infopkl/app/controllers/page_index_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  Get.put(PageIndexController(), permanent: true);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {}
        print(snapshot.data);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          // initialRoute: Routes.ADD_MAHASISWA,
          initialRoute:
              snapshot.data != null ? Routes.HOME : Routes.INTRODUCTION,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}


// void main() async {
//   Get.put(PageIndexController(), permanent: true);
//   final authC = Get.put(AuthController());

//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // Cek apakah aplikasi baru pertama kali diinstal
//   final isFirstTime = GetStorage().read('isFirstTime') ?? true;

//   // Jika aplikasi baru pertama kali diinstal, tampilkan halaman Introduction
//   if (isFirstTime) {
//     GetStorage().write('isFirstTime',
//         true); // Set isFirstTime menjadi false agar tidak tampil lagi di instalasi berikutnya
//     runApp(GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Application",
//       initialRoute: Routes.INTRODUCTION,
//       getPages: AppPages.routes,
//     ));
//   } else {
//     runApp(
//       StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return MaterialApp(
//               home: Scaffold(
//                 body: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             );
//           } else {
//             // Cek apakah user telah login sebelumnya
//             if (snapshot.data != null) {
//               authC.isAuth.value = true;
//               authC.isSkipIntro.value =
//                   true; // Jika sudah login, skip halaman Introduction
//             } else {
//               authC.isAuth.value = false;
//             }
//           }

//           return GetMaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: "Application",
//             initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
//             // initialRoute: authC.isSkipIntro.isTrue
//             //     ? authC.isAuth.isTrue
//             //         ? Routes.HOME
//             //         : Routes.LOGIN
//             //     : Routes.INTRODUCTION,
//             getPages: AppPages.routes,
//           );
//         },
//       ),
//     );
//   }
// }


