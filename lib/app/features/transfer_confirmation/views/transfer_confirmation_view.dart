import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mynthone/app/features/transfer_summary/views/transfer_summary_view.dart';

import '../../../constants/app_numbers.dart';
import '../../../helpers/log_helper.dart';
import '../../../models/account_model.dart';
import '../../../models/beneficiary_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_alert_dialog_widget.dart';
import '../../../widgets/go_back_button_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controllers/transfer_confirmation_controller.dart';

class TransferConfirmationViewArgs {
  final String amountSend;
  final String reference;
  final Beneficiary beneficiary;
  final Account account;

  TransferConfirmationViewArgs({
    required this.amountSend,
    required this.reference,
    required this.beneficiary,
    required this.account,
  });
}

class TransferConfirmationView extends GetView<TransferConfirmationController> {
  const TransferConfirmationView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.isLoading ? false : true,
      child: Stack(
        children: [
          const Scaffold(
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
          ),
          _buildLoadingOverlay()
        ],
      ),
    );
  }

  Obx _buildLoadingOverlay() {
    return Obx(() => LoadingOverlay(isLoading: controller.isLoading));
  }
}

class _BodyWidget extends GetView<TransferConfirmationController> {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final transferConfirmationViewArgs =
        Get.arguments as TransferConfirmationViewArgs;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TransferFromWidget(
              transferConfirmationViewArgs: transferConfirmationViewArgs),
          const SizedBox(
            height: 20,
          ),
          _TransferToWidget(
              transferConfirmationViewArgs: transferConfirmationViewArgs),
          const SizedBox(
            height: 20,
          ),
          _TransferAmount(
              transferConfirmationViewArgs: transferConfirmationViewArgs),
          const SizedBox(
            height: 30,
          ),
          _TransferConfirmationButton()
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
                      'Verify your transaction'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.h2445D4,
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Please double check the transfer details before you proceed'
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

class _TransferFromWidget extends StatelessWidget {
  const _TransferFromWidget({
    required this.transferConfirmationViewArgs,
  });

  final TransferConfirmationViewArgs transferConfirmationViewArgs;

  @override
  Widget build(BuildContext context) {
    final formatBalance = NumberFormat("#,##0.00", "en_US");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.hE8E8E8),
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
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
            transferConfirmationViewArgs.account.alias,
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
                  '${transferConfirmationViewArgs.account.accountNumber.accountNumber}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.h403E51,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Text(
                ' ${formatBalance.format(double.parse(transferConfirmationViewArgs.account.balance))}',
                style: GoogleFonts.firaCode(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.h403E51,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TransferToWidget extends StatelessWidget {
  const _TransferToWidget({
    required this.transferConfirmationViewArgs,
  });

  final TransferConfirmationViewArgs transferConfirmationViewArgs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.hE8E8E8),
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
      ),
      child: Column(
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
          const Divider(
            thickness: 1,
            height: 20,
            color: AppColors.hD0D0D0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  transferConfirmationViewArgs.beneficiary.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.h403E51,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Text(
                transferConfirmationViewArgs
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
    );
  }
}

class _TransferAmount extends StatelessWidget {
  const _TransferAmount({
    required this.transferConfirmationViewArgs,
  });

  final TransferConfirmationViewArgs transferConfirmationViewArgs;
  @override
  Widget build(BuildContext context) {
    final formatBalance = NumberFormat("#,##0.00", "en_US");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.hE8E8E8),
            borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount & fees',
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${transferConfirmationViewArgs.account.currency.symbolPrefix} ${formatBalance.format(double.parse(transferConfirmationViewArgs.amountSend))}',
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
                    'Amount to be sent',
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
                      '${transferConfirmationViewArgs.account.currency.symbolPrefix} 0.00',
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
                      '${transferConfirmationViewArgs.account.currency.symbolPrefix} 0.00',
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
              const Divider(
                thickness: 1,
                height: 20,
                color: AppColors.hD0D0D0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${transferConfirmationViewArgs.account.currency.symbolPrefix} ${formatBalance.format(double.parse(transferConfirmationViewArgs.amountSend))}',
                      style: GoogleFonts.firaCode(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.h403E51,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.h403E51,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          '*Should arrive in 1-2 business days',
          maxLines: 3,
          overflow: null,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.hF14C4C,
              ),
        ),
      ],
    );
  }
}

class _TransferConfirmationButton extends StatefulWidget {
  @override
  State<_TransferConfirmationButton> createState() =>
      _TransferConfirmationButtonState();
}

class _TransferConfirmationButtonState
    extends State<_TransferConfirmationButton> {
  final transferFundController = TransferConfirmationController.find;

  late Worker _signInStatusWorker;

  @override
  void initState() {
    super.initState();
    _setUpTransferConfirmationStatusWorker();
  }

  @override
  void dispose() {
    _signInStatusWorker.dispose();
    super.dispose();
  }

  void _setUpTransferConfirmationStatusWorker() {
    _signInStatusWorker = ever(
      transferFundController.status,
      (value) {
        if (value == TransferConfirmationStatus.error) {
          Log.printError(transferFundController.currentState);
          final title = 'transferFund Error'.tr;
          final message = transferFundController.errorMessage;
          _showErrorDialog(context, title: title, message: message);
        }

        if (value == TransferConfirmationStatus.succeeded) {
          Log.printInfo(transferFundController.currentState);

          final transferConfirmationViewArgs =
              Get.arguments as TransferConfirmationViewArgs;

          final args = TransferSummaryViewArgs(
              amountSend: transferConfirmationViewArgs.amountSend,
              reference: transferConfirmationViewArgs.reference,
              beneficiary: transferConfirmationViewArgs.beneficiary,
              account: transferConfirmationViewArgs.account);
          Get.offAllNamed(AppPages.transferSummary, arguments: args);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final transferConfirmationViewArgs =
        Get.arguments as TransferConfirmationViewArgs;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
          onPressed: () {
            transferFundController.transferFund(
                amountSend: transferConfirmationViewArgs.amountSend,
                reference: transferConfirmationViewArgs.reference,
                beneficiaryId: transferConfirmationViewArgs.beneficiary.id,
                accountId: transferConfirmationViewArgs.account.id);

            Log.printInfo(transferFundController.currentState);
          },
          child: Text(
            'Continue'.tr,
          )),
    );
  }

  Future<void> _showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CustomAlertDialogWidget(
            title: title,
            message: message,
            onPressed: () {},
          ),
        );
      },
    );
  }
}
