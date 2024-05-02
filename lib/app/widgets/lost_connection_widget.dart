import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helpers/asset_path_helper.dart';
import '../themes/app_colors.dart';

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
          Text(
            'Connection Dropped',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.hF6F6F6,
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            'Please check your internet connection',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.hD0D0D0,
                  fontSize: 15,
                ),
          ),
        ],
      ),
    );
  }
}
