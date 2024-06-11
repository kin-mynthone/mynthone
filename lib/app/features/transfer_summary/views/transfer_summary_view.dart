import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_numbers.dart';
import '../../../models/account_model.dart';
import '../../../models/beneficiary_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/eye_icon_widget.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/transfer_summary_controller.dart';

class TransferSummaryViewArgs {
  final String amountSend;
  final String reference;
  final Beneficiary beneficiary;
  final Account account;

  TransferSummaryViewArgs({
    required this.amountSend,
    required this.reference,
    required this.beneficiary,
    required this.account,
  });
}

class TransferSummaryView extends GetView<TransferSummaryController> {
  const TransferSummaryView({super.key});
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

class _BodyWidget extends GetView<TransferSummaryController> {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final transferSummaryViewArgs = Get.arguments as TransferSummaryViewArgs;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TransferToWidget(transferSummaryViewArgs: transferSummaryViewArgs),
          const SizedBox(
            height: 20,
          ),
          _TransferAmountWidget(
              transferSummaryViewArgs: transferSummaryViewArgs),
          const SizedBox(
            height: 20,
          ),
          _TransferFeesWidget(transferSummaryViewArgs: transferSummaryViewArgs),
          const SizedBox(
            height: 20,
          ),
          _TransferFromWidget(transferSummaryViewArgs: transferSummaryViewArgs),
          const SizedBox(
            height: 30,
          ),
          _GotoDashboardButton(transferSummaryViewArgs: transferSummaryViewArgs)
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, MMM d yyyy; hh:mm:ss a (GMT +8)');

    Duration offset = const Duration(hours: 8);
    DateTime nowWithOffset = now.add(offset);

    String formattedDate = formatter.format(nowWithOffset);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 5, 20),
      color: AppColors.hF2F4FE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your transfer was successful!'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.h2445D4,
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      formattedDate,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.h403E51,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Confirmation No. 1723842192334'.tr,
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

class _TransferToWidget extends StatelessWidget {
  const _TransferToWidget({
    required this.transferSummaryViewArgs,
  });

  final TransferSummaryViewArgs transferSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transfer to',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.h403E51,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          decoration: BoxDecoration(
            color: AppColors.hF6F6F6,
            borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Beneficiary',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      transferSummaryViewArgs.beneficiary.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.h403E51,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Text(
                    transferSummaryViewArgs
                        .beneficiary.accountNumber.accountNumber,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.h403E51,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TransferAmountWidget extends StatelessWidget {
  const _TransferAmountWidget({
    required this.transferSummaryViewArgs,
  });

  final TransferSummaryViewArgs transferSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    final formatBalance = NumberFormat("#,##0.00", "en_US");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transfer amount',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.h403E51,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.hF6F6F6,
            borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
          ),
          child: Text(
            '${transferSummaryViewArgs.account.currency.symbolPrefix} ${formatBalance.format(double.parse(transferSummaryViewArgs.amountSend))}',
            style: GoogleFonts.firaCode(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.h403E51,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TransferFeesWidget extends StatelessWidget {
  const _TransferFeesWidget({
    required this.transferSummaryViewArgs,
  });

  final TransferSummaryViewArgs transferSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transfer amount',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.h403E51,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.hF6F6F6,
              borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${transferSummaryViewArgs.account.currency.symbolPrefix} 0.00',
                        style: GoogleFonts.firaCode(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.h403E51,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Transfer fee',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.h403E51,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${transferSummaryViewArgs.account.currency.symbolPrefix} 0.00',
                        style: GoogleFonts.firaCode(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.h403E51,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Conversion rate',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.h403E51,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class _TransferFromWidget extends GetView<TransferSummaryController> {
  const _TransferFromWidget({
    required this.transferSummaryViewArgs,
  });

  final TransferSummaryViewArgs transferSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.hF6F6F6,
            borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transferSummaryViewArgs.account.alias,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Row(
                    children: [
                      controller.obscuredAccountNumber
                          ? Text(
                              hideFirstFourDigits(transferSummaryViewArgs
                                  .account.accountNumber.accountNumber
                                  .toString()),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.h403E51,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                            )
                          : Text(
                              transferSummaryViewArgs
                                  .account.accountNumber.accountNumber
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.h403E51,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                      IconButton(
                        onPressed: () =>
                            controller.toggleObscuredAccountNumber(),
                        icon: controller.obscuredAccountNumber
                            ? const EyeIcon()
                            : const SlashEyeIcon(),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class _GotoDashboardButton extends StatelessWidget {
  const _GotoDashboardButton({
    required this.transferSummaryViewArgs,
  });

  final TransferSummaryViewArgs transferSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
          onPressed: () {
            final args =
                DashboardViewArgs(account: transferSummaryViewArgs.account);
            Get.offAllNamed(AppPages.dashboard, arguments: args);
          },
          child: Text(
            'Continue'.tr,
          )),
    );
  }
}

String hideFirstFourDigits(String number) {
  if (number.length <= 4) {
    return number;
  }
  return '****${number.substring(number.length - 4)}';
}
