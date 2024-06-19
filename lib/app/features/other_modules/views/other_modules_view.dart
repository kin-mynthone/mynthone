import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../models/account_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/go_back_button_widget.dart';
import '../../beam_and_go/bng_home/views/bng_home_view.dart';
import '../controllers/other_modules_controller.dart';

class OtherModulesViewArgs {
  final Account account;

  OtherModulesViewArgs({
    required this.account,
  });
}

class OtherModulesView extends GetView<OtherModulesController> {
  const OtherModulesView({super.key});
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
      padding: const EdgeInsets.fromLTRB(0, 60, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GoBackButton(
                onPressed: () => Get.back(closeOverlays: true),
                iconColor: AppColors.h403E51,
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
        children: [_BeamAndGoWidget()],
      ),
    );
  }
}

class _BeamAndGoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final otherModulesViewArgs = Get.arguments as OtherModulesViewArgs;

    return GestureDetector(
      onTap: () {
        final args = BNGHomeViewArgs(account: otherModulesViewArgs.account);
        Get.offAllNamed(AppPages.bngHome, arguments: args);
      },
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
