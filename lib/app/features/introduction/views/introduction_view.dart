import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/Custom_text_widget.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.h425AC2,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.introBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppNumbers.screenPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextWidget(
                  text: 'The Digital wallet that connects global'.tr,
                  color: AppColors.hF6F6F6,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  centerAlignment: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextWidget(
                  text: 'Banking Beyond, Welcome to the super experience'.tr,
                  color: AppColors.hF6F6F6,
                  fontSize: 18,
                  centerAlignment: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(AppPages.onboarding),
                    child: Text('Continue'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
