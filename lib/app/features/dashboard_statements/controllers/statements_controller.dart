import 'package:get/get.dart';

import '../../../models/statement_model.dart';

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
      final previousStatementFromServer = [
        Statement(
            id: '1',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Receive',
            note: 'Transfer to savings card'),
        Statement(
            id: '2',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Transfer',
            note: 'Transfer to savings card'),
        Statement(
            id: '3',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Receive',
            note: 'Transfer to savings card'),
        Statement(
            id: '4',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Receive',
            note: 'Transfer to savings card'),
        Statement(
            id: '5',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Transfer',
            note: 'Transfer to savings card'),
      ];
      _statement.value = previousStatementFromServer;
      _status.value = StatementStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = StatementStatus.error;
    }
  }
}
