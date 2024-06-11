import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mynthone/app/constants/app_numbers.dart';
import 'package:mynthone/app/features/transfer_confirmation/views/transfer_confirmation_view.dart';
import 'package:mynthone/app/features/transfer_fund/controllers/transfer_fund_controller.dart';

import '../../../helpers/log_helper.dart';
import '../../../models/account_model.dart';
import '../../../models/beneficiary_model.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_alert_dialog_widget.dart';
import '../../../widgets/go_back_button_widget.dart';
import '../controllers/local_auth_controller.dart';

class TransferFundViewArgs {
  final Account account;

  TransferFundViewArgs({
    required this.account,
  });
}

class TransferFundView extends StatelessWidget {
  const TransferFundView({super.key});

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
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TransferFromWidget(transferFundViewArgs: transferFundViewArgs),
            const SizedBox(
              height: 20,
            ),
            _TransferToWidget(),
            const SizedBox(
              height: 20,
            ),
            _TransferAmount(transferFundViewArgs: transferFundViewArgs),
            const SizedBox(
              height: 20,
            ),
            _ReferenceWidget(),
            const SizedBox(
              height: 30,
            ),
            _LocalAuthCheckerButton()
          ],
        ),
      ),
    );
  }
}

class _ReferenceWidget extends GetView<TransferFundController> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'reference',
      controller: controller.referenceEditingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value!.length.isGreaterThan(110)) {
          return 'Max 110 characters'.tr;
        }
        return null;
      },
      maxLength: 110,
      maxLines: 3,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: 'Add note(Optional)'.tr,
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
                ),
              ),
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
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: Colors.white,
              child: const _BottomSheetBeneficiaryWidget(),
            );
          },
        );
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.hE8E8E8),
            borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
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
              controller.gotSelectedBeneficiary
                  ? const SelectedBeneficiaryWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedBeneficiaryWidget extends GetView<TransferFundController> {
  const SelectedBeneficiaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
          height: 20,
          color: AppColors.hD0D0D0,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                controller.selectedBeneficiary.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Text(
              controller.selectedBeneficiary.accountNumber.accountNumber,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.h403E51,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BottomSheetBeneficiaryWidget extends StatelessWidget {
  const _BottomSheetBeneficiaryWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _BottomSheetHeaderWidget(),
        _BeneficiaryListWidget(),
      ],
    );
  }
}

class _BottomSheetHeaderWidget extends StatelessWidget {
  const _BottomSheetHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppNumbers.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Transfer To',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),

          //  const _SearchFormField(),
        ],
      ),
    );
  }
}

class _BeneficiaryListWidget extends GetView<TransferFundController> {
  const _BeneficiaryListWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemCount: controller.beneficiary.length,
          itemBuilder: (context, index) {
            final beneficiary = controller.beneficiary[index];
            return _BeneficiaryListTileWidget(
              beneficiary: beneficiary,
            );
          },
        ),
      ),
    );
  }
}

class _BeneficiaryListTileWidget extends GetView<TransferFundController> {
  const _BeneficiaryListTileWidget({
    required this.beneficiary,
  });

  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        title: Text(
          beneficiary.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h403E51,
              ),
        ),
        subtitle: Text(
          beneficiary.accountNumber.accountNumber,
          maxLines: 2,
          overflow: null,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.h8E8E8E,
                fontSize: 11,
              ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          controller.selectBeneficiary(beneficiary: beneficiary);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _TransferAmount extends GetView<TransferFundController> {
  const _TransferAmount({
    required this.transferFundViewArgs,
  });

  final TransferFundViewArgs transferFundViewArgs;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
            color: AppColors.hF6F6F6,
          ),
          child: Text(
            transferFundViewArgs.account.currency.symbolPrefix,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.h403E51,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: FormBuilderTextField(
            name: 'amount',
            controller: controller.amountEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Amount is required'.tr;
              }
              return null;
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            autocorrect: false,
            style: GoogleFonts.firaCode(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.h403E51,
              ),
            ),
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              fillColor: AppColors.hF6F6F6,
              hintText: '0.00'.tr,
              filled: true,
              border: InputBorder.none,
              hintStyle: GoogleFonts.firaCode(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.h403E51,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _LocalAuthCheckerButton extends StatefulWidget {
  @override
  State<_LocalAuthCheckerButton> createState() =>
      _LocalAuthCheckerButtonState();
}

class _LocalAuthCheckerButtonState extends State<_LocalAuthCheckerButton> {
  final transferFundController = TransferFundController.find;
  final localAuthController = LocalAuthController.find;

  late Worker _localAuthStatusWorker;

  @override
  void initState() {
    super.initState();
    _setUpTransferFundStatusWorker();
  }

  @override
  void dispose() {
    _localAuthStatusWorker.dispose();
    super.dispose();
  }

  void _setUpTransferFundStatusWorker() {
    _localAuthStatusWorker = ever(
      localAuthController.status,
      (value) {
        if (value == LocalAuthStatus.noAuthSetup) {}
        if (value == LocalAuthStatus.authenticated) {
          final transferFundViewArgs = Get.arguments as TransferFundViewArgs;

          final args = TransferConfirmationViewArgs(
              amountSend: transferFundController.amountEditingController.text,
              reference: transferFundController.referenceEditingController.text,
              beneficiary: transferFundController.selectedBeneficiary,
              account: transferFundViewArgs.account);
          Get.toNamed(AppPages.transferConfirmation, arguments: args);
        }
        if (value == LocalAuthStatus.failed) {
          Log.printError(transferFundController.currentState);
          final title = 'Authentication Failed'.tr;
          const message = 'Please try again';
          _showErrorDialog(context, title: title, message: message);
        }
        if (value == LocalAuthStatus.error) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            final isValidForm = transferFundController.validateForm();

            if (!isValidForm) {
              Log.printWarning('Invalid transferFund Form');
              final title = 'transferFund Error'.tr;
              final message = 'Ensure that the form is properly filled in.'.tr;
              _showErrorDialog(context, title: title, message: message);

              return;
            }

            localAuthController.authenticateUser(context);
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
