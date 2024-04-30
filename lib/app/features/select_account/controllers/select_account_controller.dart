import 'package:get/get.dart';

import '../../../models/account_model.dart';
import '../../../repository/accounts_repository.dart';

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
      'SelectAccountController(status: ${_status.value} errorMessage: ${_errorMessage.value}, accountsLength: ${_accounts.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    _status.value = SelectAccountStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));

      _accounts.value = await AccountRepository.fetchAccounts();
      _status.value = SelectAccountStatus.succeeded;
    } catch (e) {
      _errorMessage.value = e.toString();
      _status.value = SelectAccountStatus.error;
    }
  }
}
