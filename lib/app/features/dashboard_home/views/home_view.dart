import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/features/other_modules/views/other_modules_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/app_numbers.dart';
import '../../../constants/app_strings.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../models/statement_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/loading_indicator_widget.dart';
import '../../card_info/views/card_info_view.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../transfer_fund/views/transfer_fund_view.dart';
import '../controllers/home_controller.dart';
import '../controllers/home_statement_controller.dart';

part '../widgets/announcement_list_widget.dart';
part '../widgets/cards_list_widget.dart';
part '../widgets/buttons_widget.dart';
part '../widgets/statement_widget.dart';
part '../widgets/front_card_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _HeaderTitleWidget(),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AssetPath.notification,
                height: 30,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //_AnnouncementListWidget(),
            SizedBox(
              height: 20,
            ),
            // _CardsListWidget(),
            _FrontCardWidget(),
            _ButtonsWidget(),
            _StatementWidget(),
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
    final dashboardViewArgs = Get.arguments as DashboardViewArgs;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => DashboardController.find.toggleDrawer(),
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                AppStrings.defaultProfile,
              ),
            ),
          ),
        ),
        Text(
          dashboardViewArgs.account.alias,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h2445D4,
                fontSize: 15,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
