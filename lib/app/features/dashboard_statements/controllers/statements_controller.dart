import 'package:get/get.dart';

import '../../../models/statement_model.dart';
import '../../../repository/statement_repository.dart';

enum StatementStatus { initial, loading, succeeded, error }

class StatementController extends GetxController {
  static StatementController get find => Get.find();

  final _status = StatementStatus.initial.obs;
  Rx<StatementStatus> get status => _status;
  bool get isLoading => _status.value == StatementStatus.loading;

  final _statement = <Statement>[].obs;
  List<Statement> get statement => _statement;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'StatementController(status: ${_status.value} errorMessage: ${_errorMessage.value}, statementLength: ${_statement.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchCardStatement();
  }

  Future<void> _fetchCardStatement() async {
    _status.value = StatementStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      _statement.value = await StatementRepository.fetchAllStatements();
      _status.value = StatementStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = StatementStatus.error;
    }
  }
}
