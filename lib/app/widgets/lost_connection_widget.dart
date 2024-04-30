import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helpers/asset_path_helper.dart';
import '../themes/app_colors.dart';
import 'custom_text_widget.dart';

class ConnectionLost extends StatelessWidget {
  const ConnectionLost({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            AssetPath.noConnection,
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 30),
          const CustomTextWidget(
            text: 'Connection Dropped',
            color: AppColors.hF6F6F6,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          const SizedBox(height: 5),
          const CustomTextWidget(
            text: 'Please check your internet connection',
            color: AppColors.hD0D0D0,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ],
      ),
    );
  }
}
