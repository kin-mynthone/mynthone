import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_numbers.dart';
import '../../../../helpers/asset_path_helper.dart';
import '../../../../models/account_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/go_back_button_widget.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../controllers/bng_home_controller.dart';

class BNGHomeViewArgs {
  final Account account;

  BNGHomeViewArgs({
    required this.account,
  });
}

class BNGHomeView extends GetView<BNGHomeController> {
  const BNGHomeView({super.key});
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
    final bngHomeViewArgs = Get.arguments as BNGHomeViewArgs;

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
                      DashboardViewArgs(account: bngHomeViewArgs.account);
                  Get.offAllNamed(AppPages.dashboard, arguments: args);
                },
                iconColor: AppColors.h403E51,
              ),
              Image.asset(
                AssetPath.beamAndGo,
                height: 50,
                fit: BoxFit.contain,
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

class _BeamAndGoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Image.asset(
          AssetPath.beamAndGo,
          width: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
