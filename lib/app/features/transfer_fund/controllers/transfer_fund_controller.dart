import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../models/beneficiary_model.dart';
import '../../../repository/beneficiary_repository.dart';

enum TransferFundStatus { initial, loading, succeeded, error }

class TransferFundController extends GetxController {
  static TransferFundController get find => Get.find();

  final _status = TransferFundStatus.initial.obs;
  Rx<TransferFundStatus> get status => _status;
  bool get isLoading => _status.value == TransferFundStatus.loading;

  final _beneficiary = <Beneficiary>[].obs;
  List<Beneficiary> get beneficiary => _beneficiary;

  late Beneficiary _selectedBeneficiary;
  Beneficiary get selectedBeneficiary => _selectedBeneficiary;

  final _gotSelectedBeneficiary = false.obs;
  bool get gotSelectedBeneficiary => _gotSelectedBeneficiary.value;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> get formKey => _formKey;

  late TextEditingController _amountEditingController;
  TextEditingController get amountEditingController => _amountEditingController;

  late TextEditingController _referenceEditingController;
  TextEditingController get referenceEditingController =>
      _referenceEditingController;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'TransferFundController(status: ${_status.value} errorMessage: ${_errorMessage.value})';

  @override
  void onInit() {
    super.onInit();
    _amountEditingController = TextEditingController();
    _referenceEditingController = TextEditingController();

    _fetchBeneficiary();
  }

  @override
  void onClose() {
    _amountEditingController.dispose();
    _referenceEditingController.dispose();
    super.onClose();
  }

  bool validateForm() {
    final isValid =
        _formKey.currentState!.isValid && _gotSelectedBeneficiary.isTrue;

    return isValid;
  }

  Future<void> _fetchBeneficiary() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      _beneficiary.value =
          await BeneficiaryRepository.fetchBeneficiaryBeneficiary();
    } catch (e) {
      _errorMessage.value = 'Error description here';
    }
  }

  void selectBeneficiary({required Beneficiary beneficiary}) {
    _gotSelectedBeneficiary.value = true;
    _selectedBeneficiary = beneficiary;
  }
}
