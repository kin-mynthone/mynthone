import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../helpers/asset_path_helper.dart';
import '../../../models/statement_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../statement_info/views/statement_info_view.dart';
import '../controllers/statements_controller.dart';

part '../widget/statement_widget.dart';

class StatementView extends GetView<StatementController> {
  const StatementView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_HeaderWidget(), _StatementWidget()],
      ),
    );
  }
}

class _HeaderWidget extends GetView<StatementController> {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      color: AppColors.hF2F4FE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statements'.tr,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.h2445D4,
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            'Your previous statements are listed here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.h403E51,
                ),
          ),
          const SizedBox(height: 10),
          const _SearchFormField(),
        ],
      ),
    );
  }
}

class _SearchFormField extends GetView<StatementController> {
  const _SearchFormField();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.hBDBDBD),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetPath.magnifier,
              height: 15,
              colorFilter: const ColorFilter.mode(
                AppColors.hE06144,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Enter names, card number',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.h8E8E8E,
                    ),
              ),
            ),
            SvgPicture.asset(
              AssetPath.filter,
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
