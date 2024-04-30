import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/env_helper.dart';
import '../../../helpers/log_helper.dart';
import '../../../utils/api_error_util.dart';
import '../views/auth_otp_view.dart';

enum AuthOtpStatus { initial, loading, succeeded, error }

class AuthOtpController extends GetxController {
  static AuthOtpController get find => Get.find();

  final _status = AuthOtpStatus.initial.obs;
  Rx<AuthOtpStatus> get status => _status;
  bool get isLoading => _status.value == AuthOtpStatus.loading;

  final _otp = ''.obs;
  String get otp => _otp.value;

  final _countryCode = ''.obs;
  String get countryCode => _countryCode.value;

  final _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;

  static const _waitingTimeForResend = 10;
  late Timer _timer;
  final _secondsRemaining = _waitingTimeForResend.obs;
  int get secondsRemaining => _secondsRemaining.value;

  final _resendEnabled = false.obs;
  bool get resendEnabled => _resendEnabled.value;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'AuthOtpController(status: ${_status.value} errorMessage: ${_errorMessage.value})';

  @override
  void onInit() {
    super.onInit();
    _setOtpInitialValue();
    _setMobileNumberInitialValue();
    _setCountryCodeInitialValue();
  }

  @override
  void onReady() {
    super.onReady();
    _startCountdown();
  }

  void _setOtpInitialValue() {
    final args = Get.arguments as AuthOtpViewArgs;
    _otp.value = args.otp;
    Log.printInfo('OTP: ${_otp.value}');
  }

  void _setMobileNumberInitialValue() {
    final args = Get.arguments as AuthOtpViewArgs;
    _mobileNumber.value = args.mobileNumber;
    Log.printInfo('Mobile Number: ${_mobileNumber.value}');
  }

  void _setCountryCodeInitialValue() {
    final args = Get.arguments as AuthOtpViewArgs;
    _countryCode.value = args.countryCode;
    Log.printInfo('Country Code: ${_countryCode.value}');
  }

  void _startCountdown() {
    _secondsRemaining.value = _waitingTimeForResend;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (_secondsRemaining.value != 0) {
          _secondsRemaining.value--;
        } else {
          _timer.cancel();

          _resendEnabled.value = true;
        }
      },
    );
  }

  void requestOtp() async {
    _status.value = AuthOtpStatus.loading;
    try {
      final forgotPasswordApiEndpoint =
          dotenv.get(Env.forgotPasswordApiEndpoint);

      final url = Uri.parse('$forgotPasswordApiEndpoint/otp');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'countryCode': _countryCode.value.trim(),
        'mobileNumber': _mobileNumber.value.trim(),
      });

      final response = await http.post(url, headers: headers, body: body);

      final isSuccessful = response.statusCode == 200;
      final data = jsonDecode(response.body);
      Log.printInfo('Data from server: $data');

      if (!isSuccessful) {
        throw ApiError(data['error']);
      }

      final code = data['code'];
      _otp.value = code;

      _resendEnabled.value = false;
      _startCountdown();
      _status.value = AuthOtpStatus.succeeded;
      Log.printInfo('Resent OTP');
    } on ApiError catch (e) {
      Log.printError(e);
      _errorMessage.value = 'Unable to resend OTP at the moment'.tr;
      _status.value = AuthOtpStatus.error;
    } catch (e) {
      Log.printError(e);
      _errorMessage.value = 'An error occurred. Please try again later.'.tr;
      _status.value = AuthOtpStatus.error;
    }
  }
}
