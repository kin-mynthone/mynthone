import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/env_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../instances/firebase_service_instances.dart';
import '../../../utils/api_error_util.dart';

enum SignInStatus { initial, loading, succeeded, error }

class SignInController extends GetxController {
  static SignInController get find => Get.find();

  final _status = SignInStatus.initial.obs;
  Rx<SignInStatus> get status => _status;
  bool get isLoading => _status.value == SignInStatus.loading;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> get formKey => _formKey;

  late TextEditingController _mobileNumberEditingController;
  TextEditingController get mobileNumberEditingController =>
      _mobileNumberEditingController;

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
    _mobileNumberEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void onClose() {
    _mobileNumberEditingController.dispose();
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
    final mobileNumber = _mobileNumberEditingController.text.trim();
    final password = _passwordEditingController.text.trim();
    final countryCode = _countryCode.value.trim();
    Log.printInfo('Credentials: $countryCode| $mobileNumber | $password');
    return isValid;
  }

  Future<void> signIn() async {
    _status.value = SignInStatus.loading;
    try {
      Log.printInfo('Logging in');

      final mobileNumber = _mobileNumberEditingController.text.trim();
      final password = _passwordEditingController.text.trim();
      final countryCode = _countryCode.value.trim();
      Log.printInfo('Credentials: $countryCode| $mobileNumber | $password');

      final signInApiEndpoint = dotenv.get(Env.signInApiEndpoint, fallback: '');
      final url = Uri.parse(signInApiEndpoint);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'countryCode': countryCode,
        'mobileNumber': mobileNumber,
        'password': password,
      });

      final response = await http.post(url, headers: headers, body: body);

      final isSuccessful = response.statusCode == 200;
      final data = jsonDecode(response.body);
      Log.printInfo('Data from server: $data');

      if (!isSuccessful) {
        throw ApiError(data['error']);
      }

      final token = data['token'];
      final userCredential = await firebaseAuth.signInWithCustomToken(token);
      final uid = userCredential.user?.uid;

      _status.value = SignInStatus.succeeded;
      Log.printInfo('Logged in successfully $uid');
    } on ApiError catch (e) {
      Log.printError(e);
      final message = 'Mobile number or password is incorrect'.tr;
      _errorMessage.value = message;
      _status.value = SignInStatus.error;
    } catch (e) {
      Log.printError(e);
      final message = 'An error occurred. Please try again later.'.tr;
      _errorMessage.value = message;
      _status.value = SignInStatus.error;
    }
  }

  Future<void> _getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    _currentVersion.value = '${info.version}.${info.buildNumber}';
  }
}
