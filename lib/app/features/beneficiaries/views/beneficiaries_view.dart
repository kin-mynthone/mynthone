import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/beneficiaries_controller.dart';

class BeneficiariesView extends GetView<BeneficiariesController> {
  const BeneficiariesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeneficiariesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BeneficiariesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
