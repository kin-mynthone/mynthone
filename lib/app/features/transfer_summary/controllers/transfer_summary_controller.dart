import 'package:get/get.dart';

class TransferSummaryController extends GetxController {
  final _obscuredAccountNumber = true.obs;
  bool get obscuredAccountNumber => _obscuredAccountNumber.value;

  void toggleObscuredAccountNumber() {
    _obscuredAccountNumber.value = !_obscuredAccountNumber.value;
  }
}
