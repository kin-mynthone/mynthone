import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mynthone/app/constants/app_numbers.dart';
import 'package:mynthone/app/features/transfer_fund/controllers/transfer_fund_controller.dart';

import '../../../helpers/log_helper.dart';
import '../../../models/account_model.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/go_back_button_widget.dart';

class TransferFundViewArgs {
  final Account account;

  TransferFundViewArgs({
    required this.account,
  });
}

class TransferFundView extends StatefulWidget {
  const TransferFundView({super.key});

  @override
  State<TransferFundView> createState() => _TransferFundViewState();
}

class _TransferFundViewState extends State<TransferFundView> {
  final transferFundController = TransferFundController.find;

  late Worker _beneficiaryWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _beneficiaryWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _beneficiaryWorker = ever(
      transferFundController.status,
      (value) {
        if (value == TransferFundStatus.error) {
          Log.printInfo(transferFundController.currentState);
        }
        if (value == TransferFundStatus.loading) {
          Log.printInfo(transferFundController.currentState);
        }
        if (value == TransferFundStatus.succeeded) {
          Log.printInfo(transferFundController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _HeaderWidget(),
          SizedBox(
            height: 20,
          ),
          _BodyWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 60, 5, 20),
      color: AppColors.hF2F4FE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GoBackButton(
                onPressed: () => Get.back(closeOverlays: true),
                iconColor: AppColors.h403E51,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transfer to your beneficiary'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.h2445D4,
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Easily send money to your beneficiary with a few clicks.'
                          .tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.h403E51,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyWidget extends GetView<TransferFundController> {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final transferFundViewArgs = Get.arguments as TransferFundViewArgs;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TransferFromWidget(transferFundViewArgs: transferFundViewArgs),
          const SizedBox(
            height: 10,
          ),
          _TransferToWidget()
        ],
      ),
    );
  }
}

class _TransferFromWidget extends StatelessWidget {
  const _TransferFromWidget({
    required this.transferFundViewArgs,
  });

  final TransferFundViewArgs transferFundViewArgs;

  @override
  Widget build(BuildContext context) {
    final formatBalance = NumberFormat("#,##0.00", "en_US");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.hE8E8E8),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transfer from',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.h403E51,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Divider(
            thickness: 1,
            height: 20,
            color: AppColors.hD0D0D0,
          ),
          Text(
            transferFundViewArgs.account.alias,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.h403E51,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${transferFundViewArgs.account.accountNumber.accountNumber}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.h403E51,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Text(
                  ' ${formatBalance.format(double.parse(transferFundViewArgs.account.balance))}',
                  style: GoogleFonts.firaCode(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.h403E51,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class _TransferToWidget extends GetView<TransferFundController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open Bottom sheet
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.hE8E8E8),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transfer to',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.h403E51,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: Colors.black87,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
