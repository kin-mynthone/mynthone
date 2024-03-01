import 'package:flutter/material.dart';
import 'package:get/utils.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/asset_path_helper.dart';
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
                const CustomTextWidget(
                  text: 'The Digital wallet that connects global',
                  color: AppColors.hF6F6F6,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  centerAlignment: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                const CustomTextWidget(
                  text: 'Banking Beyond, Welcome to the super experience',
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
                    onPressed: () {},
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
