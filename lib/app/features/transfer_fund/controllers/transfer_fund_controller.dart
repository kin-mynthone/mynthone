import 'package:get/get.dart';
import '../../../models/beneficiary_model.dart';
import '../../../repository/beneficiary_repository.dart';
import '../../../repository/transfer_fund_repository.dart';

enum TransferFundStatus { initial, loading, succeeded, error }

class TransferFundController extends GetxController {
  static TransferFundController get find => Get.find();

  final _status = TransferFundStatus.initial.obs;
  Rx<TransferFundStatus> get status => _status;
  bool get isLoading => _status.value == TransferFundStatus.loading;

  final _beneficiary = <Beneficiary>[].obs;
  List<Beneficiary> get beneficiary => _beneficiary;

  final _selectedBeneficiary = null;
  Beneficiary get selectedBeneficiary => _selectedBeneficiary;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'TransferFundController(status: ${_status.value} errorMessage: ${_errorMessage.value})';

  Future<void> transferFund() async {
    _status.value = TransferFundStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      await TransferFundRepository.transferFund(
          amountSend: 123, reference: '', beneficiaryId: '', accountId: '');
      _status.value = TransferFundStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = TransferFundStatus.error;
    }
  }

  Future<void> fetchBeneficiary() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      _beneficiary.value =
          await BeneficiaryRepository.fetchBeneficiaryBeneficiary();
    } catch (e) {
      _errorMessage.value = 'Error description here';
    }
  }
}
