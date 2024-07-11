import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mynthone/app/models/account_model.dart';

import '../../../../constants/app_numbers.dart';
import '../../../../models/voucher_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/eye_icon_widget.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../controllers/purchase_summary_controller.dart';

class PurchaseSummaryViewArgs {
  final Account account;
  final Voucher voucher;
  final int quantity;
  final String beneficiaryName;
  final String beneficiaryMobile;

  PurchaseSummaryViewArgs({
    required this.account,
    required this.voucher,
    required this.quantity,
    required this.beneficiaryName,
    required this.beneficiaryMobile,
  });
}

class PurchaseSummaryView extends GetView<PurchaseSummaryController> {
  const PurchaseSummaryView({super.key});
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
                      'Purchasing voucher was successful!'.tr,
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

class _BodyWidget extends GetView<PurchaseSummaryController> {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final purchaseSummaryViewArgs = Get.arguments as PurchaseSummaryViewArgs;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VoucherBeneficiaryWidget(
              purchaseSummaryViewArgs: purchaseSummaryViewArgs),
          const SizedBox(
            height: 20,
          ),
          _VoucherWidget(purchaseSummaryViewArgs: purchaseSummaryViewArgs),
          const SizedBox(
            height: 20,
          ),
          _PurchaseFeesWidget(purchaseSummaryViewArgs: purchaseSummaryViewArgs),
          const SizedBox(
            height: 20,
          ),
          _PaidFromWidget(purchaseSummaryViewArgs: purchaseSummaryViewArgs),
          const SizedBox(
            height: 30,
          ),
          _GotoDashboardButton(purchaseSummaryViewArgs: purchaseSummaryViewArgs)
        ],
      ),
    );
  }
}

class _VoucherBeneficiaryWidget extends StatelessWidget {
  const _VoucherBeneficiaryWidget({
    required this.purchaseSummaryViewArgs,
  });

  final PurchaseSummaryViewArgs purchaseSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beneficiary',
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
          child: Row(
            children: [
              Expanded(
                child: Text(
                  purchaseSummaryViewArgs.beneficiaryName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.h403E51,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VoucherWidget extends StatelessWidget {
  const _VoucherWidget({
    required this.purchaseSummaryViewArgs,
  });

  final PurchaseSummaryViewArgs purchaseSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voucher',
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
            purchaseSummaryViewArgs.voucher.name,
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

class _PurchaseFeesWidget extends StatelessWidget {
  const _PurchaseFeesWidget({
    required this.purchaseSummaryViewArgs,
  });

  final PurchaseSummaryViewArgs purchaseSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    final formatBalance = NumberFormat("#,##0.00", "en_US");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Purchased',
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
                        '${purchaseSummaryViewArgs.voucher.unitPriceCurrencyCode} ${formatBalance.format(double.parse(purchaseSummaryViewArgs.voucher.unitPrice.toString()))}',
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
                      'Voucher price',
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
                        '${purchaseSummaryViewArgs.voucher.unitPriceCurrencyCode} ${formatBalance.format(double.parse('0'))}',
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
                      'Processing fee',
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

class _PaidFromWidget extends GetView<PurchaseSummaryController> {
  const _PaidFromWidget({
    required this.purchaseSummaryViewArgs,
  });

  final PurchaseSummaryViewArgs purchaseSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Paid from',
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
                purchaseSummaryViewArgs.account.alias,
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
                              hideFirstFourDigits(purchaseSummaryViewArgs
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
                              purchaseSummaryViewArgs
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

String hideFirstFourDigits(String number) {
  if (number.length <= 4) {
    return number;
  }
  return '****${number.substring(number.length - 4)}';
}

class _GotoDashboardButton extends StatelessWidget {
  const _GotoDashboardButton({
    required this.purchaseSummaryViewArgs,
  });

  final PurchaseSummaryViewArgs purchaseSummaryViewArgs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
          onPressed: () {
            final args =
                DashboardViewArgs(account: purchaseSummaryViewArgs.account);
            Get.offAllNamed(AppPages.dashboard, arguments: args);
          },
          child: Text(
            'Continue'.tr,
          )),
    );
  }
}
