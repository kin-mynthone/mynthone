import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/account_model.dart';
import '../../../themes/app_colors.dart';
import '../controllers/dashboard_controller.dart';

part '../widgets/body_widget.dart';
part '../widgets/bottom_navigation_bar_widget.dart';

class DashboardViewArgs {
  final Account account;

  DashboardViewArgs({
    required this.account,
  });
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyWidget(),
      bottomNavigationBar: _BottomNavigationBarWidget(),
    );
  }
}
