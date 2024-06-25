import 'package:get/get.dart';

import '../../../../models/voucher_model.dart';

enum MerchantsStatus { initial, loading, succeeded, error }

class MerchantsController extends GetxController {
  static MerchantsController get find => Get.find();

  final _status = MerchantsStatus.initial.obs;
  Rx<MerchantsStatus> get status => _status;
  bool get isLoading => _status.value == MerchantsStatus.loading;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final _voucher = <Voucher>[].obs;
  List<Voucher> get voucher => _voucher;

  String get currentState =>
      'MerchantsController(status: ${_status.value} errorMessage: ${_errorMessage.value}, voucherLength: ${_voucher.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchVouchers();
  }

  // Future<void> _fetchVoucher() async {
  //   _status.value = MerchantsStatus.loading;
  //   try {
  //     await Future.delayed(const Duration(seconds: 1));

  //     // _voucher.value =
  //     _status.value = MerchantsStatus.succeeded;
  //   } catch (e) {
  //     _errorMessage.value = e.toString();
  //     _status.value = MerchantsStatus.error;
  //   }
  // }

  Future<void> _fetchVouchers() async {
    _status.value = MerchantsStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final voucherFromServer = [
        Voucher(
          productSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          code: 'PRINCE',
          name: 'Prince Hypermart GC',
          description: 'A digital gift certificate that will be sent',
          productTypeId: 1,
          productTypeName: 'SUPERMARKET',
          unitPrice: 1000,
          unitPriceCurrencyCode: 'PHP',
          imageUrl:
              'https://pnghq.com/wp-content/uploads/walmart-logo-transparent-png-22100282-png-png-download.png',
          minQty: 1,
          maxQty: 4,
          stockQty: 39,
          defaultQty: 1,
          isBranchSpecific: false,
          branchSid: '',
          branchCode: '',
          branchName: '',
          isShippingRequired: false,
          isBirthdateRequired: false,
          accountSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          shippingAndHandlingFee: 0,
        ),
        Voucher(
          productSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          code: 'PRINCE',
          name: 'Prince Hypermart GC',
          description: 'A digital gift certificate that will be sent',
          productTypeId: 1,
          productTypeName: 'SUPERMARKET',
          unitPrice: 1000,
          unitPriceCurrencyCode: 'PHP',
          imageUrl:
              'https://pnghq.com/wp-content/uploads/walmart-logo-transparent-png-22100282-png-png-download.png',
          minQty: 1,
          maxQty: 4,
          stockQty: 39,
          defaultQty: 1,
          isBranchSpecific: false,
          branchSid: '',
          branchCode: '',
          branchName: '',
          isShippingRequired: false,
          isBirthdateRequired: false,
          accountSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          shippingAndHandlingFee: 0,
        ),
        Voucher(
          productSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          code: 'PRINCE',
          name: 'Prince Hypermart GC',
          description: 'A digital gift certificate that will be sent',
          productTypeId: 1,
          productTypeName: 'SUPERMARKET',
          unitPrice: 1000,
          unitPriceCurrencyCode: 'PHP',
          imageUrl:
              'https://pnghq.com/wp-content/uploads/walmart-logo-transparent-png-22100282-png-png-download.png',
          minQty: 1,
          maxQty: 4,
          stockQty: 39,
          defaultQty: 1,
          isBranchSpecific: false,
          branchSid: '',
          branchCode: '',
          branchName: '',
          isShippingRequired: false,
          isBirthdateRequired: false,
          accountSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          shippingAndHandlingFee: 0,
        ),
      ];
      _voucher.value = voucherFromServer;
      _status.value = MerchantsStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = MerchantsStatus.error;
    }
  }
}
