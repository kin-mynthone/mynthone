import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/features/beam_and_go/select_beneficiary/controllers/select_beneficiary_controller.dart';
import 'package:mynthone/app/models/voucher_model.dart';

import '../../../../constants/app_numbers.dart';
import '../../../../helpers/log_helper.dart';
import '../../../../models/account_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../../../../widgets/custom_alert_dialog_widget.dart';
import '../../../../widgets/go_back_button_widget.dart';
import '../../purchase_summary/views/purchase_summary_view.dart';

class SelectBeneficiaryViewArgs {
  final Account account;
  final Voucher voucher;
  final int quantity;

  SelectBeneficiaryViewArgs({
    required this.account,
    required this.voucher,
    required this.quantity,
  });
}

class SelectBeneficiaryView extends StatelessWidget {
  const SelectBeneficiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectBeneficiaryViewArgs =
        Get.arguments as SelectBeneficiaryViewArgs;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _HeaderWidget(),
          const SizedBox(
            height: 20,
          ),
          _BodyWidget(selectBeneficiaryViewArgs: selectBeneficiaryViewArgs),
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
                      'Who is your Beneficiary?'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.h2445D4,
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Select or input your beneficiary details'.tr,
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

class _BodyWidget extends GetView<SelectBeneficiaryController> {
  const _BodyWidget({
    required this.selectBeneficiaryViewArgs,
  });

  final SelectBeneficiaryViewArgs selectBeneficiaryViewArgs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NameWidget(),
            const SizedBox(
              height: 20,
            ),
            _MobileNumberWidget(),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  final isValidForm = controller.validateForm();

                  if (!isValidForm) {
                    Log.printWarning('Invalid Select Beneficiary Form');
                    final title = 'Beneficiary Error'.tr;
                    final message =
                        'Ensure that the form is properly filled in.'.tr;
                    _showErrorDialog(context, title: title, message: message);

                    return;
                  }

                  final args = PurchaseSummaryViewArgs(
                      voucher: selectBeneficiaryViewArgs.voucher,
                      account: selectBeneficiaryViewArgs.account,
                      quantity: selectBeneficiaryViewArgs.quantity,
                      beneficiaryName: controller.nameEditingController.text,
                      beneficiaryMobile:
                          controller.mobileNumberEditingController.text);
                  Get.offAllNamed(AppPages.purchaseSummary, arguments: args);
                },
                child: Text(
                  'Continue'.tr,
                )),
          ],
        ),
      ),
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

class _MobileNumberWidget extends GetView<SelectBeneficiaryController> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'mobileNumber',
      controller: controller.mobileNumberEditingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Mobile number is required'.tr;
        }

        return null;
      },
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        label: Text('Mobile Number'.tr),
      ),
    );
  }
}

class _NameWidget extends GetView<SelectBeneficiaryController> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'name',
      controller: controller.nameEditingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'Name is required'.tr;
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        labelText: 'Name'.tr,
      ),
    );
  }
}
