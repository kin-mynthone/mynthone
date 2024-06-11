import 'package:get/get.dart';
import '../../../repository/transfer_fund_repository.dart';

enum TransferConfirmationStatus { initial, loading, succeeded, error }

class TransferConfirmationController extends GetxController {
  static TransferConfirmationController get find => Get.find();

  final _status = TransferConfirmationStatus.initial.obs;
  Rx<TransferConfirmationStatus> get status => _status;
  bool get isLoading => _status.value == TransferConfirmationStatus.loading;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'TransferConfirmationController(status: ${_status.value} errorMessage: ${_errorMessage.value})';

  Future<void> transferFund({
    required String amountSend,
    required String reference,
    required String beneficiaryId,
    required String accountId,
  }) async {
    _status.value = TransferConfirmationStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));

      await TransferFundRepository.transferFund(
          amountSend: amountSend,
          reference: reference.isEmpty ? 'Empty' : reference,
          beneficiaryId: beneficiaryId,
          accountId: accountId);
      _status.value = TransferConfirmationStatus.succeeded;
    } catch (e) {
      _errorMessage.value = e.toString();
      _status.value = TransferConfirmationStatus.error;
    }
  }
}
