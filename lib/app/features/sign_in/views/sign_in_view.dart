import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:get/get.dart';

import '../../../constants/app_numbers.dart';
import '../../../constants/app_strings.dart';
import '../../../helpers/asset_path_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_text_widget.dart';
import '../../../widgets/eye_icon_widget.dart';
import '../../../widgets/slash_eye_icon_widget.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.h425AC2,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.loginBg),
            fit: BoxFit.cover,
          ),
        ),
        child: const SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
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
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.hF6F6F6,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppNumbers.cornerRadius),
            topRight: Radius.circular(AppNumbers.cornerRadius),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppNumbers.screenPadding, vertical: 30),
          child: Column(
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
                height: 50,
              ),
              _SignInButton(),
              SizedBox(
                height: 5,
              ),
              _GotoRegistration(),
              Spacer(),
              _AppVersion(),
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

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Sign In'.tr),
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
        text: '${controller.currentVersion} v',
        color: AppColors.h8E8E8E,
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
    );
  }
}
