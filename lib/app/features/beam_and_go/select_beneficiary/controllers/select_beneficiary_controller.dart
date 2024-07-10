import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

enum SelectBeneficiaryStatus { initial, loading, succeeded, error }

class SelectBeneficiaryController extends GetxController {
  static SelectBeneficiaryController get find => Get.find();

  final _status = SelectBeneficiaryStatus.initial.obs;
  Rx<SelectBeneficiaryStatus> get status => _status;
  bool get isLoading => _status.value == SelectBeneficiaryStatus.loading;

  final _gotSelectedBeneficiary = false.obs;
  bool get gotSelectedBeneficiary => _gotSelectedBeneficiary.value;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> get formKey => _formKey;

  late TextEditingController _nameEditingController;
  TextEditingController get nameEditingController => _nameEditingController;

  late TextEditingController _mobileNumberEditingController;
  TextEditingController get mobileNumberEditingController =>
      _mobileNumberEditingController;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'SelectBeneficiaryController(status: ${_status.value} errorMessage: ${_errorMessage.value})';

  @override
  void onInit() {
    super.onInit();
    _nameEditingController = TextEditingController();
    _mobileNumberEditingController = TextEditingController();
  }

  @override
  void onClose() {
    _nameEditingController.dispose();
    _mobileNumberEditingController.dispose();
    super.onClose();
  }

  bool validateForm() {
    final isValid =
        _formKey.currentState!.isValid && _gotSelectedBeneficiary.isTrue;

    return isValid;
  }
}
