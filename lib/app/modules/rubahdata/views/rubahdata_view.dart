import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rubahdata_controller.dart';

class RubahdataView extends GetView<RubahdataController> {
  const RubahdataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RubahdataView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RubahdataView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
