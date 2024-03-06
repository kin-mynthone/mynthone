import 'package:get/get.dart';

import '../../../models/account_model.dart';

enum SelectAccountStatus { initial, loading, succeeded, error }

class SelectAccountController extends GetxController {
  static SelectAccountController get find => Get.find();

  final _status = SelectAccountStatus.initial.obs;
  Rx<SelectAccountStatus> get status => _status;
  bool get isLoading => _status.value == SelectAccountStatus.loading;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final _accounts = <Account>[].obs;
  List<Account> get accounts => _accounts;

  String get currentState =>
      'ForgotPasswordOTPController(status: ${_status.value} errorMessage: ${_errorMessage.value}, accountsLength: ${_accounts.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    _status.value = SelectAccountStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final accountsFromServer = [
        Account(
            id: '1',
            name: 'Account 1',
            description: 'Description for Account 1',
            profileUrl: ''),
        Account(
            id: '2',
            name: 'Account 2',
            description: 'Description for Account 2',
            profileUrl: ''),
        Account(
            id: '3',
            name: 'Account 3',
            description: 'Description for Account 3',
            profileUrl: ''),
      ];
      _accounts.value = accountsFromServer;
      _status.value = SelectAccountStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = SelectAccountStatus.error;
    }
  }
}
