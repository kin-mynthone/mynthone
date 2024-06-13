import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/routes/app_pages.dart';

import '../../../../constants/app_numbers.dart';
import '../../../../models/account_model.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/go_back_button_widget.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../controllers/merchants_controller.dart';

class MerchantsViewArgs {
  final Account account;

  MerchantsViewArgs({
    required this.account,
  });
}

class MerchantsView extends GetView<MerchantsController> {
  const MerchantsView({super.key});
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
    final merchantsViewArgs = Get.arguments as MerchantsViewArgs;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 60, 5, 20),
      color: AppColors.hF2F4FE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GoBackButton(
                onPressed: () {
                  final args =
                      DashboardViewArgs(account: merchantsViewArgs.account);
                  Get.offAllNamed(AppPages.dashboard, arguments: args);
                },
                iconColor: AppColors.h403E51,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Merchants'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.h2445D4,
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Beam and Go Partners in serving Overseas Workers'.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.h403E51,
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

class _BodyWidget extends StatelessWidget {
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
