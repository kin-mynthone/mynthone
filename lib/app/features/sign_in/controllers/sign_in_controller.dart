import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/log_helper.dart';
import '../../../helpers/persistent_storage_helper.dart';
import '../../../instances/supabase_service_instances.dart';
import '../../../repository/sign_in_repository.dart';
import '../../../utils/api_error_util.dart';

enum SignInStatus { initial, loading, succeeded, error }

class SignInController extends GetxController {
  static SignInController get find => Get.find();

  final _status = SignInStatus.initial.obs;
  Rx<SignInStatus> get status => _status;
  bool get isLoading => _status.value == SignInStatus.loading;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> get formKey => _formKey;

  late TextEditingController _emailOrUsernameEditingController;
  TextEditingController get emailOrUsernameEditingController =>
      _emailOrUsernameEditingController;

  final _countryCode = AppStrings.defaultCountryCode.obs;
  String get countryCode => _countryCode.value;

  final _dialCode = AppStrings.defaultDialCode.obs;
  String get dialCode => _dialCode.value;

  late TextEditingController _passwordEditingController;
  TextEditingController get passwordEditingController =>
      _passwordEditingController;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final _obscuredPassword = true.obs;
  bool get obscuredPassword => _obscuredPassword.value;

  final _currentVersion = ''.obs;
  String get currentVersion => _currentVersion.value;

  String get currentState =>
      'SignInController(status: ${_status.value}, currentVersion: ${_currentVersion.value}, errorMessage: ${_errorMessage.value}, )';

  @override
  void onInit() {
    super.onInit();
    _getAppVersion();
    _emailOrUsernameEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void onClose() {
    _emailOrUsernameEditingController.dispose();
    _passwordEditingController.dispose();
    super.onClose();
  }

  void toggleObscuredPassword() {
    _obscuredPassword.value = !_obscuredPassword.value;
  }

  void setDialCodeValue(countryDialCode) {
    _dialCode.value = countryDialCode;
  }

  void setCountryCodeValue(countryIsoCode) {
    _countryCode.value = countryIsoCode;
  }

  bool validateForm() {
    final isValid = _formKey.currentState?.isValid ?? false;
    final emailOrUsername = _emailOrUsernameEditingController.text.trim();
    final password = _passwordEditingController.text.trim();
    final countryCode = _countryCode.value.trim();
    Log.printInfo('Credentials: $countryCode| $emailOrUsername | $password');
    return isValid;
  }

  Future<void> signIn() async {
    _status.value = SignInStatus.loading;
    try {
      Log.printInfo('Logging in');

      // await supabase.auth.signInWithPassword(
      //   email: emailOrUsernameEditingController.text,
      //   password: passwordEditingController.text,
      // );

      final signInAccount = await SignInRepository.signInAccount(
          email: emailOrUsernameEditingController.text,
          password: passwordEditingController.text);

      await PersistentStorage.setSignedCredentials(
          email: emailOrUsernameEditingController.text,
          password: passwordEditingController.text);

      await PersistentStorage.setAccessToken(
        accessToken: signInAccount.accessToken,
      );

      _status.value = SignInStatus.succeeded;

      Log.printInfo('Logged in successfully ${supabase.auth.currentUser?.id}');
    } on ApiError catch (e) {
      Log.printError(e);
      final message = 'Email/User ID or password is incorrect'.tr;
      _errorMessage.value = message;
      _status.value = SignInStatus.error;
    } catch (e) {
      Log.printError(e);
      String message = 'An error occurred. Please try again later.'.tr;

      if (e.toString().contains('Invalid login credentials')) {
        message = 'Invalid credentials'.tr;
      }

      _errorMessage.value = message;
      _status.value = SignInStatus.error;
    }
  }

  Future<void> _getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    _currentVersion.value = '${info.version}.${info.buildNumber}';
  }
}
