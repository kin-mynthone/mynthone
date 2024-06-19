import 'package:get/get.dart';

import '../../../../models/voucher_model.dart';

enum BNGHomeStatus { initial, loading, succeeded, error }

class BNGHomeController extends GetxController {
  static BNGHomeController get find => Get.find();

  final _status = BNGHomeStatus.initial.obs;
  Rx<BNGHomeStatus> get status => _status;
  bool get isLoading => _status.value == BNGHomeStatus.loading;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final _voucher = <Voucher>[].obs;
  List<Voucher> get voucher => _voucher;

  String get currentState =>
      'BNGHomeController(status: ${_status.value} errorMessage: ${_errorMessage.value}, voucherLength: ${_voucher.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchVoucher();
  }

  Future<void> _fetchVoucher() async {
    _status.value = BNGHomeStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));

      // _voucher.value =
      _status.value = BNGHomeStatus.succeeded;
    } catch (e) {
      _errorMessage.value = e.toString();
      _status.value = BNGHomeStatus.error;
    }
  }

  final voucherFromServer = [
    Voucher(
      productSid: '',
      code: '',
      name: '',
      description: '',
      productTypeId: 0,
      productTypeName: '',
      unitPrice: 0,
      unitPriceCurrencyCode: '',
      imageUrl: '',
      minQty: 0,
      maxQty: 0,
      stockQty: 0,
      defaultQty: 0,
      isBranchSpecific: true,
      branchSid: '',
      branchCode: '',
      branchName: '',
      isShippingRequired: true,
      isBirthdateRequired: true,
      accountSid: '',
      shippingAndHandlingFee: 0,
    )
  ];
}
