import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:local_auth/local_auth.dart';

import '../../../enums/local_auth_support_state_enum.dart';
import '../../../helpers/log_helper.dart';

enum LocalAuthStatus {
  initial,
  authenticating,
  authenticated,
  noAuthSetup,
  failed,
  error,
}

class LocalAuthController extends GetxController {
  static LocalAuthController get find => Get.find();

  final _status = LocalAuthStatus.initial.obs;
  Rx<LocalAuthStatus> get status => _status;

  String currentState() => 'LocalAuthController(_status: ${_status.value},';

  final LocalAuthentication auth = LocalAuthentication();

  final _supportState = LocalAuthSupportState.unknown.obs;
  LocalAuthSupportState get supportState => _supportState.value;

  final _canCheckBiometrics = false.obs;
  bool get canCheckBiometrics => _canCheckBiometrics.value;

  @override
  void onInit() {
    super.onInit();
    Log.printInfo(currentState());
    auth.isDeviceSupported().then((bool isSupported) => _supportState.value =
        isSupported
            ? LocalAuthSupportState.supported
            : LocalAuthSupportState.unsupported);
  }

  Future<void> checkBiometrics(context) async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      Log.printError(e);
    }
    if (!context.mounted) {
      return;
    }

    _canCheckBiometrics.value = canCheckBiometrics;
  }

  Future<void> authenticate(context) async {
    bool authenticated = false;
    try {
      _status.value = LocalAuthStatus.authenticating;
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      Log.printError(e);
      _status.value = LocalAuthStatus.error;
      return;
    }
    if (!context.mounted) {
      return;
    }
    authenticated
        ? _status.value = LocalAuthStatus.authenticated
        : _status.value = LocalAuthStatus.failed;

    Log.printInfo(authenticated.toString());
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    _status.value = LocalAuthStatus.failed;
  }

  Future<void> authenticateUser(context) async {
    await checkBiometrics(context);
    if (_canCheckBiometrics.value) {
      authenticate(context);
    } else {
      _status.value = LocalAuthStatus.noAuthSetup;
    }
  }
}
