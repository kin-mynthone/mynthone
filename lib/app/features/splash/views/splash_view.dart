import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../helpers/asset_path_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/loading_indicator_widget.dart';
import '../controllers/auth_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final authController = AuthController.find;
  late Worker _authStatusWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _authStatusWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _authStatusWorker = ever(
      authController.status,
      (value) {
        if (value == AuthStatus.error) {
          Log.printInfo(authController.currentState);
        }
        if (value == AuthStatus.unauthenticated) {
          Log.printInfo(authController.currentState);
          Get.offAllNamed(AppPages.signIn);
        }
        if (value == AuthStatus.authenticated) {
          Log.printInfo(authController.currentState);
          Get.offAllNamed(AppPages.selectAccount);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.h425AC2,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetPath.mynthLogo,
              height: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            const LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
