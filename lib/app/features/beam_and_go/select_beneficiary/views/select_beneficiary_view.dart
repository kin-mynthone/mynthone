import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/models/voucher_model.dart';

import '../../../../models/account_model.dart';
import '../controllers/select_beneficiary_controller.dart';

class SelectBeneficiaryViewArgs {
  final Account account;
  final Voucher voucher;
  final int quantity;

  SelectBeneficiaryViewArgs({
    required this.account,
    required this.voucher,
    required this.quantity,
  });
}

class SelectBeneficiaryView extends GetView<SelectBeneficiaryController> {
  const SelectBeneficiaryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectBeneficiaryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SelectBeneficiaryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
