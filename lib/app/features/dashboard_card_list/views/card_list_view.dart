import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/card_list_controller.dart';

class CardListView extends GetView<CardListController> {
  const CardListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CardListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CardListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
