import 'package:get/get.dart';
import '../modules/Addtdatapkl/bindings/addtdatapkl_binding.dart';
import '../modules/Addtdatapkl/views/addtdatapkl_view.dart';
import '../modules/FavoritMenu/bindings/favorit_menu_binding.dart';
import '../modules/FavoritMenu/views/favorit_menu_view.dart';
import '../modules/Profil/bindings/profil_binding.dart';
import '../modules/Profil/views/profil_view.dart';
import '../modules/UpdatePassword/bindings/update_password_binding.dart';
import '../modules/UpdatePassword/views/update_password_view.dart';
import '../modules/UpdateProfil/bindings/update_profil_binding.dart';
import '../modules/UpdateProfil/views/update_profil_view.dart';
import '../modules/add_mahasiswa/bindings/add_mahasiswa_binding.dart';
import '../modules/add_mahasiswa/views/add_mahasiswa_view.dart';
import '../modules/detail_pkl/bindings/detail_pkl_binding.dart';
import '../modules/detail_pkl/views/detail_pkl_view.dart';
import '../modules/hasilrating/bindings/hasilrating_binding.dart';
import '../modules/hasilrating/views/hasilrating_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/kuesioner/bindings/kuesioner_binding.dart';
import '../modules/kuesioner/views/kuesioner_view.dart';
import '../modules/kuesioner_hasil/bindings/kuesioner_hasil_binding.dart';
import '../modules/kuesioner_hasil/views/kuesioner_hasil_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/lupa_password/views/lupa_password_view.dart';
import '../modules/new-password/bindings/new_password_binding.dart';
import '../modules/new-password/views/new_password_view.dart';
import '../modules/rubahdata/bindings/rubahdata_binding.dart';
import '../modules/rubahdata/views/rubahdata_view.dart';
import '../modules/update_data/bindings/update_data_binding.dart';
import '../modules/update_data/views/update_data_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_MAHASISWA,
      page: () => const AddMahasiswaView(),
      binding: AddMahasiswaBinding(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.KUESIONER,
      page: () => KuesionerView(),
      binding: KuesionerBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FAVORIT_MENU,
      page: () => FavoritMenuView(),
      binding: FavoritMenuBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => LupaPasswordView(),
      binding: LupaPasswordBinding(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFIL,
      page: () => UpdateProfilView(),
      binding: UpdateProfilBinding(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.ADDTDATAPKL,
      page: () => const AddtdatapklView(),
      binding: AddtdatapklBinding(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.DETAIL_PKL,
      page: () => DetailPklView(),
      binding: DetailPklBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.HASILRATING,
      page: () => const HasilratingView(),
      binding: HasilratingBinding(),
    ),
    GetPage(
      name: _Paths.KUESIONER_HASIL,
      page: () => KuesionerHasilView(),
      binding: KuesionerHasilBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.RUBAHDATA,
      page: () => const RubahdataView(),
      binding: RubahdataBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_DATA,
      page: () => UpdateDataView(),
      binding: UpdateDataBinding(),
    ),
  ];
}
