import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ordered_voucher_summary_controller.dart';

class OrderedVoucherSummaryView
    extends GetView<OrderedVoucherSummaryController> {
  const OrderedVoucherSummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderedVoucherSummaryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OrderedVoucherSummaryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
