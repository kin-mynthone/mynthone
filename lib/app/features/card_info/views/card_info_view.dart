import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/card_info_controller.dart';

class CardInfoView extends GetView<CardInfoController> {
  const CardInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CardInfoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CardInfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
