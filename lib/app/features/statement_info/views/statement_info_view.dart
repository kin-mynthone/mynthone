import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_numbers.dart';
import '../../../models/statement_model.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/go_back_button_widget.dart';
import '../controllers/statement_info_controller.dart';

class StatementInfoViewArgs {
  final Statement statement;

  StatementInfoViewArgs({
    required this.statement,
  });
}

class StatementInfoView extends GetView<StatementInfoController> {
  const StatementInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: AppNumbers.screenPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            _HeaderWidget(),
            SizedBox(
              height: 20,
            ),
            _BodyWidget(),
          ],
        ),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final statementInfoViewArgs = Get.arguments as StatementInfoViewArgs;
    final formatBalance = NumberFormat("#,##0.00", "en_US");

    return Center(
      child: statementInfoViewArgs.statement.received
          ? Text(
              '${statementInfoViewArgs.statement.currency} ${formatBalance.format(double.parse(statementInfoViewArgs.statement.amount))}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    color: AppColors.h1BBE49,
                  ),
            )
          : Text(
              '${statementInfoViewArgs.statement.account} ${formatBalance.format(double.parse(statementInfoViewArgs.statement.amount))}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    color: AppColors.hF14C4C,
                  ),
            ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    final statementInfoViewArgs = Get.arguments as StatementInfoViewArgs;

    return Row(
      children: [
        GoBackButton(
          onPressed: () => Get.back(closeOverlays: true),
          iconColor: AppColors.h2445D4,
        ),
        statementInfoViewArgs.statement.received
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statementInfoViewArgs.statement.sender.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  Text(
                    'Received to: ${statementInfoViewArgs.statement.account.alias}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statementInfoViewArgs.statement.beneficiary.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  Text(
                    'Transferred from: ${statementInfoViewArgs.statement.account.alias}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ],
              ),
      ],
    );
  }
}
