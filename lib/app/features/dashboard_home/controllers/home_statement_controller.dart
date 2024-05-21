import 'package:get/get.dart';
import 'package:mynthone/app/features/dashboard/views/dashboard_view.dart';

import '../../../helpers/log_helper.dart';
import '../../../models/statement_model.dart';
import '../../../repository/statement_repository.dart';

enum HomeStatementStatus { initial, loading, succeeded, error }

class HomeStatementController extends GetxController {
  static HomeStatementController get find => Get.find();

  final _status = HomeStatementStatus.initial.obs;
  Rx<HomeStatementStatus> get status => _status;
  bool get isLoading => _status.value == HomeStatementStatus.loading;

  final _statement = <Statement>[].obs;
  List<Statement> get statement => _statement;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'HomeStatementController(status: ${_status.value},  errorMessage: ${_errorMessage.value}, statementLength: ${_statement.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchPreviousStatement();
  }

  Future<void> _fetchPreviousStatement() async {
    _status.value = HomeStatementStatus.loading;

    try {
      final dashboardViewArgs = Get.arguments as DashboardViewArgs;
      _statement.value = await StatementRepository.fetchAccountStatements(
          accountID: dashboardViewArgs.account.id);

      _status.value = HomeStatementStatus.succeeded;
    } catch (e) {
      Log.printError(e);
      _errorMessage.value = 'Error description here';
      _status.value = HomeStatementStatus.error;
    }
  }
}
