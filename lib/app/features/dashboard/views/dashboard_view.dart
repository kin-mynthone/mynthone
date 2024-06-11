import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../models/account_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../dashboard_home/views/home_view.dart';
import '../../dashboard_statements/views/statements_view.dart';
import '../../splash/controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/drawer_left_child_widget.dart';

part '../widgets/dashboard_body_widget.dart';
part '../widgets/bottom_navigation_bar_widget.dart';

class DashboardViewArgs {
  final Account account;

  DashboardViewArgs({
    required this.account,
  });
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final dashboardController = DashboardController.find;
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
          Get.offAllNamed(
            AppPages.signIn,
          );
        }

        if (value == AuthStatus.authenticated) {
          Log.printInfo(authController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: dashboardController.innerDrawerKey,
      onTapClose: true,
      swipe: true,
      colorTransitionChild: AppColors.h2445D4,
      colorTransitionScaffold: Colors.transparent,
      offset: const IDOffset.only(bottom: 0.0, right: 0.0, left: 0.7),
      scale: const IDOffset.horizontal(0.8),
      proportionalChildArea: true,
      borderRadius: 30,
      leftAnimationType: InnerDrawerAnimation.static,
      backgroundDecoration: const BoxDecoration(color: AppColors.h2445D4),
      leftChild: const DrawerLeftChildWidget(),
      scaffold: const Scaffold(
        body: _DashboardBodyWidget(),
        bottomNavigationBar: _BottomNavigationBarWidget(),
      ),
    );
  }
}
