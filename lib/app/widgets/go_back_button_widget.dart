import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_colors.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    super.key,
    required this.onPressed,
    this.iconColor = AppColors.h425AC2,
  });

  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: 'Go back'.tr,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        Icons.arrow_back,
        color: iconColor,
        size: 35,
      ),
    );
  }
}
