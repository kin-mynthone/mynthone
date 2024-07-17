import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_numbers.dart';
import '../../../../models/ordered_voucher_model.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/go_back_button_widget.dart';
import '../controllers/ordered_voucher_summary_controller.dart';

class OrderedVoucherSummaryViewArgs {
  final OrderedVoucher orderedVoucher;

  OrderedVoucherSummaryViewArgs({
    required this.orderedVoucher,
  });
}

class OrderedVoucherSummaryView
    extends GetView<OrderedVoucherSummaryController> {
  const OrderedVoucherSummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _HeaderWidget(),
          SizedBox(
            height: 20,
          ),
          _BodyWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 60, 5, 20),
      color: AppColors.hF2F4FE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GoBackButton(
                onPressed: () => Get.back(closeOverlays: true),
                iconColor: AppColors.h403E51,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Voucher Summary'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.h2445D4,
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyWidget extends GetView<OrderedVoucherSummaryController> {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
