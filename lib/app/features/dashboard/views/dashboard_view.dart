import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../models/account_model.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_text_widget.dart';
import '../../home/views/home_view.dart';
import '../controllers/dashboard_controller.dart';

part '../widgets/body_widget.dart';
part '../widgets/bottom_navigation_bar_widget.dart';
part '../widgets/drawer_left_child_widget.dart';

class DashboardViewArgs {
  final Account account;

  DashboardViewArgs({
    required this.account,
  });
}

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: controller.innerDrawerKey,
      onTapClose: true,
      swipe: true,
      colorTransitionChild: AppColors.h425AC2,
      colorTransitionScaffold: Colors.transparent,
      offset: const IDOffset.only(bottom: 0.0, right: 0.0, left: 0.7),
      scale: const IDOffset.horizontal(0.8),
      proportionalChildArea: true,
      borderRadius: 30,
      leftAnimationType: InnerDrawerAnimation.static,
      backgroundDecoration: const BoxDecoration(color: AppColors.h425AC2),
      leftChild: const _DrawerLeftChildWidget(),
      scaffold: const Scaffold(
        body: _BodyWidget(),
        bottomNavigationBar: _BottomNavigationBarWidget(),
      ),
    );
  }
}
