import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:get/get.dart';
import 'package:mynthone/app/features/auth_otp/views/auth_otp_view.dart';
import 'package:mynthone/app/routes/app_pages.dart';

import '../../../constants/app_numbers.dart';
import '../../../constants/app_strings.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_text_widget.dart';
import '../../../widgets/eye_icon_widget.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../../../widgets/slash_eye_icon_widget.dart';
import '../../splash/controllers/auth_controller.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final signInController = SignInController.find;
  final authController = AuthController.find;
  late Worker _authStatusWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _authStatusWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _authStatusWorker = ever(
      authController.status,
      (value) {
        if (value == AuthStatus.error) {
          Log.printInfo(authController.currentState);
        }

        if (value == AuthStatus.unauthenticated) {
          Log.printInfo(authController.currentState);
        }

        if (value == AuthStatus.authenticated) {
          Log.printInfo(authController.currentState);
          //TODO: add dashboard
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: signInController.isLoading ? false : true,
      child: Stack(
        children: [
          Container(
            height: screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetPath.loginBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppNumbers.screenPadding),
                    child: _HeaderWidget(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  _BodyWidget(),
                ],
              ),
            ),
          ),
          _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Obx _buildLoadingOverlay() {
    return Obx(() => LoadingOverlay(isLoading: signInController.isLoading));
  }
}

class _BodyWidget extends GetView<SignInController> {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.hF6F6F6,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppNumbers.cornerRadius),
            topRight: Radius.circular(AppNumbers.cornerRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppNumbers.screenPadding, vertical: 30),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: FormBuilder(
                  key: controller.formKey,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _MobileNumberTextFormField(),
                      SizedBox(
                        height: 20,
                      ),
                      _PasswordTextFormField(),
                      _GotoForgotPassword(),
                      SizedBox(
                        height: 40,
                      ),
                      _SignInButton(),
                      SizedBox(
                        height: 5,
                      ),
                      _GotoRegistration(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.03,
                right: 0,
                child: const _AppVersion(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: 'Hi, Welcome Back'.tr,
          color: AppColors.hF6F6F6,
          fontWeight: FontWeight.w700,
          fontSize: 28,
        ),
        const SizedBox(
          height: 8,
        ),
        CustomTextWidget(
          text: 'Please sign in to continue'.tr,
          color: AppColors.hF6F6F6,
          fontSize: 15,
          centerAlignment: true,
        ),
      ],
    );
  }
}

class _MobileNumberTextFormField extends GetView<SignInController> {
  const _MobileNumberTextFormField();

  @override
  Widget build(BuildContext context) {
    const countryPicker = FlCountryCodePicker(
      countryTextStyle: TextStyle(color: Colors.black),
      dialCodeTextStyle: TextStyle(color: Colors.black),
    );

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
        prefixIcon: GestureDetector(
          onTap: () async {
            final country = await countryPicker.showPicker(
              context: context,
              barrierColor: AppColors.barrierColor,
              scrollToDeviceLocale: true,
            );

            if (country == null) {
              return;
            }

            final dialCode = country.dialCode;
            final countryIsoCode = country.code;

            Log.printInfo('Country ISO code: $countryIsoCode');
            Log.printInfo('Country dial code: $dialCode');

            controller.setDialCodeValue(dialCode);
            controller.setCountryCodeValue(countryIsoCode);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_drop_down),
                Obx(() => Text(controller.dialCode)),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextFormField extends GetView<SignInController> {
  const _PasswordTextFormField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FormBuilderTextField(
        name: 'password',
        controller: controller.passwordEditingController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (value == null || value.trim().isEmpty) {
            return 'Password is required'.tr;
          }

          return null;
        },
        keyboardType: TextInputType.text,
        obscureText: controller.obscuredPassword,
        obscuringCharacter: AppStrings.obscuringCharacter,
        textInputAction: TextInputAction.done,
        autocorrect: false,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => controller.toggleObscuredPassword(),
            icon: controller.obscuredPassword
                ? const EyeIcon()
                : const SlashEyeIcon(),
          ),
          label: Text('Password'.tr),
        ),
      ),
    );
  }
}

class _GotoForgotPassword extends StatelessWidget {
  const _GotoForgotPassword();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: CustomTextWidget(
        text: 'Forgot Password?'.tr,
        color: AppColors.h8E8E8E,
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),
    );
  }
}

class _GotoRegistration extends StatelessWidget {
  const _GotoRegistration();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: CustomTextWidget(
          text: 'Open an account'.tr,
          color: AppColors.h8E8E8E,
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _AppVersion extends GetView<SignInController> {
  const _AppVersion();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextWidget(
        text: 'v ${controller.currentVersion}',
        color: AppColors.h8E8E8E,
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
    );
  }
}

class _SignInButton extends StatefulWidget {
  const _SignInButton();

  @override
  State<_SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<_SignInButton> {
  final signInController = SignInController.find;

  late Worker _loginStatusWorker;

  @override
  void initState() {
    super.initState();
    _setUpLoginStatusWorker();
  }

  @override
  void dispose() {
    _loginStatusWorker.dispose();
    super.dispose();
  }

  void _setUpLoginStatusWorker() {
    _loginStatusWorker = ever(
      signInController.status,
      (value) {
        if (value == SignInStatus.error) {
          Log.printInfo(signInController.currentState);
          final title = 'Login Error'.tr;
          final message = signInController.errorMessage;
          _showErrorDialog(context, title: title, message: message);
        }

        if (value == SignInStatus.loading) {
          Log.printInfo(signInController.currentState);
        }

        if (value == SignInStatus.succeeded) {
          Log.printInfo(signInController.currentState);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          final isValidForm = signInController.validateForm();

          if (!isValidForm) {
            Log.printWarning('Invalid Login Form');
            final title = 'Login Error'.tr;
            final message = 'Ensure that the form is properly filled in.'.tr;
            _showErrorDialog(context, title: title, message: message);

            return;
          }

          //TODO: add signin function
          // signInController.signIn();

          final mobileNumber =
              signInController.mobileNumberEditingController.text;
          final countryCode = signInController.countryCode;
          final dialCode = signInController.dialCode;

          final args = AuthOtpViewArgs(
            otp: '1234',
            mobileNumber: mobileNumber.trim(),
            countryCode: countryCode.trim(),
            dialCode: dialCode.trim(),
          );
          Get.offAllNamed(AppPages.authOtp, arguments: args);
          Log.printInfo(signInController.currentState);
        },
        child: Text('Login'.tr),
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
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Got it'.tr),
              ),
            ],
          ),
        );
      },
    );
  }
}
