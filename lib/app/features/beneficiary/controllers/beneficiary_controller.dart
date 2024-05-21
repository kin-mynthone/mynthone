import 'package:get/get.dart';

import '../../../models/beneficiary_model.dart';
import '../../../repository/beneficiary_repository.dart';

enum BeneficiaryStatus { initial, loading, succeeded, error }

class BeneficiaryController extends GetxController {
  static BeneficiaryController get find => Get.find();

  final _status = BeneficiaryStatus.initial.obs;
  Rx<BeneficiaryStatus> get status => _status;
  bool get isLoading => _status.value == BeneficiaryStatus.loading;

  final _beneficiary = <Beneficiary>[].obs;
  List<Beneficiary> get beneficiary => _beneficiary;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'BeneficiaryController(status: ${_status.value} errorMessage: ${_errorMessage.value}, BeneficiaryLength: ${_beneficiary.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchCardBeneficiary();
  }

  Future<void> _fetchCardBeneficiary() async {
    _status.value = BeneficiaryStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      _beneficiary.value =
          await BeneficiaryRepository.fetchBeneficiaryBeneficiary();
      _status.value = BeneficiaryStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = BeneficiaryStatus.error;
    }
  }
}
