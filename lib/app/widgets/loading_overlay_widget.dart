import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import 'loading_indicator_widget.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.barrierColor,
            child: const Center(
              child: LoadingIndicator(color: Colors.white),
            ),
          )
        : const SizedBox();
  }
}
