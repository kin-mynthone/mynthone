import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/constants/app_numbers.dart';
import 'package:mynthone/app/features/dashboard/controllers/dashboard_controller.dart';
import 'package:mynthone/app/widgets/loading_indicator_widget.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_text_widget.dart';
import '../controllers/home_controller.dart';

part '../widgets/announcement_list_widget.dart';
part '../widgets/cards_list_widget.dart';
part '../widgets/buttons_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _HeaderTitleWidget(),
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
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _AnnouncementListWidget(),
            _CardsListWidget(),
            _ButtonsWidget()
          ],
        ),
      ),
    );
  }
}

class _HeaderTitleWidget extends StatelessWidget {
  const _HeaderTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () => DashboardController.find.toggleDrawer(),
            child: const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                AppStrings.defaultProfile,
              ),
            ),
          ),
        ),
        const CustomTextWidget(
          text: 'Hi Kindred',
          color: AppColors.h425AC2,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          centerAlignment: true,
        ),
      ],
    );
  }
}
