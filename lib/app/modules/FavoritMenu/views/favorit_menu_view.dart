import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorit_menu_controller.dart';
import '../../../controllers/page_index_controller.dart';

class FavoritMenuView extends GetView<FavoritMenuController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAVORIT'),
        centerTitle: true,
        backgroundColor: const Color(0xFF000080),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.turned_in_not, title: 'Favarit'),
          TabItem(icon: Icons.mail, title: 'Kuesioner'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        backgroundColor: const Color(0xFF000080),
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
