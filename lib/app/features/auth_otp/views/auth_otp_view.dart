import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';

import '../../../helpers/asset_path_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_alert_dialog_widget.dart';
import '../../../widgets/go_back_button_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../controllers/auth_otp_controller.dart';

class AuthOtpViewArgs {
  final String otp;
  final String mobileNumber;
  final String countryCode;
  final String dialCode;

  AuthOtpViewArgs({
    required this.otp,
    required this.mobileNumber,
    required this.countryCode,
    required this.dialCode,
  });
}

class AuthOtpView extends StatefulWidget {
  const AuthOtpView({super.key});

  @override
  State<AuthOtpView> createState() => _AuthOtpViewState();
}

class _AuthOtpViewState extends State<AuthOtpView> {
  final authOtpController = AuthOtpController.find;

  late Worker _authOtpWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _authOtpWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _authOtpWorker = ever(
      authOtpController.status,
      (value) {
        if (value == AuthOtpStatus.error) {
          Log.printInfo(authOtpController.currentState);
          final title = 'OTP Error'.tr;
          final message = authOtpController.errorMessage;
          _showErrorDialog(context, title: title, message: message);
        }
        if (value == AuthOtpStatus.loading) {
          Log.printInfo(authOtpController.currentState);
        }
        if (value == AuthOtpStatus.succeeded) {
          Log.printInfo(authOtpController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobileNumber = (Get.arguments as AuthOtpViewArgs).mobileNumber;
    final dialCode = (Get.arguments as AuthOtpViewArgs).dialCode;

    return PopScope(
        canPop: authOtpController.isLoading ? false : true,
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: GoBackButton(
                  onPressed: () => Get.back(closeOverlays: true),
                  iconColor: AppColors.h2445D4,
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetPath.otpImage,
                        height: 230,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'OTP Verification'.tr,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.h2445D4,
                              fontSize: 25,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      _UserMobileNumber(
                          dialCode: dialCode, mobileNumber: mobileNumber),
                      const _OtpInputField(),
                      const _ResendWidget(),
                    ],
                  ),
                ),
              ),
            ),
            _buildLoadingOverlay(),
          ],
        ));
  }

  Obx _buildLoadingOverlay() {
    return Obx(() => LoadingOverlay(isLoading: authOtpController.isLoading));
  }
}

class _UserMobileNumber extends StatelessWidget {
  const _UserMobileNumber({
    required this.dialCode,
    required this.mobileNumber,
  });

  final String dialCode;
  final String mobileNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          'Please enter the OTP code sent to',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h8E8E8E,
                fontSize: 18,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          '$dialCode $mobileNumber',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.hE06144,
                fontSize: 18,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _OtpInputField extends GetView<AuthOtpController> {
  const _OtpInputField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: OtpTextField(
        numberOfFields: 4,
        filled: true,
        fieldWidth: 45,
        showFieldAsBox: true,
        autoFocus: true,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onSubmit: (String value) {
          final otpFromServer = controller.otp;
          final verified = otpFromServer == value.trim();

          if (!verified) {
            final title = 'OTP Error'.tr;
            final message = 'Invalid or expired OTP. Please try again.'.tr;
            _showErrorDialog(context, title: title, message: message);

            return;
          }

          //TODO: authenticate then go to dashboard
        },
      ),
    );
  }
}

class _ResendWidget extends GetView<AuthOtpController> {
  const _ResendWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        child: controller.resendEnabled
            ? const _ResendOtpButton()
            : const _ResendOtpRemainingSeconds(),
      ),
    );
  }
}

class _ResendOtpButton extends GetView<AuthOtpController> {
  const _ResendOtpButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive OTP?".tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.h2445D4,
                fontSize: 15,
              ),
        ),
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            controller.requestOtp();
          },
          child: Text(
            'Resend OTP'.tr,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.hF6F6F6,
                  fontSize: 15,
                ),
          ),
        ),
      ],
    );
  }
}

class _ResendOtpRemainingSeconds extends GetView<AuthOtpController> {
  const _ResendOtpRemainingSeconds();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        '${'Resend OTP in'.tr} ${(controller.secondsRemaining)} ${'seconds'.tr}',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.hF6F6F6,
              fontSize: 15,
            ),
      ),
    );
  }
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
          ));
    },
  );
}
