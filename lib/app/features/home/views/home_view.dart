import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/features/dashboard/controllers/dashboard_controller.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_text_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () => DashboardController.find.toggleDrawer(),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    AppStrings.defaultProfile, // Sample image URL
                  ),
                ),
              ),
            ),
            const CustomTextWidget(
              text: 'Hi Kindred',
              color: AppColors.h403E51,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              centerAlignment: true,
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AssetPath.notification,
              height: 40,
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
