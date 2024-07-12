import 'package:get/get.dart';
import 'package:mynthone/app/models/ordered_voucher_model.dart';

enum OrderedVoucherStatus { initial, loading, succeeded, error }

class OrderedVoucherController extends GetxController {
  static OrderedVoucherController get find => Get.find();

  final _status = OrderedVoucherStatus.initial.obs;
  Rx<OrderedVoucherStatus> get status => _status;
  bool get isLoading => _status.value == OrderedVoucherStatus.loading;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final _orderedVoucher = <OrderedVoucher>[].obs;
  List<OrderedVoucher> get voucher => _orderedVoucher;

  String get currentState =>
      'OrderedVoucherController(status: ${_status.value} errorMessage: ${_errorMessage.value}, voucherLength: ${_orderedVoucher.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchOrderedVouchers();
  }

  Future<void> _fetchOrderedVouchers() async {
    _status.value = OrderedVoucherStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final orderedVoucherFromServer = [
        OrderedVoucher(
          productSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          code: 'PRINCE',
          name: 'Prince Hypermart GC',
          description: 'A digital gift certificate that will be sent',
          unitPrice: 1000,
          unitPriceCurrencyCode: 'PHP',
          imageUrl:
              'https://pnghq.com/wp-content/uploads/walmart-logo-transparent-png-22100282-png-png-download.png',
          quantity: 1,
          status: 'Sent',
          beneficiaryName: 'John Doe',
          beneficiaryMobile: '09123456789',
        ),
        OrderedVoucher(
          productSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          code: 'PRINCE',
          name: 'Prince Hypermart GC',
          description: 'A digital gift certificate that will be sent',
          unitPrice: 1000,
          unitPriceCurrencyCode: 'PHP',
          imageUrl:
              'https://pnghq.com/wp-content/uploads/walmart-logo-transparent-png-22100282-png-png-download.png',
          quantity: 1,
          status: 'Validated',
          beneficiaryName: 'John Doe',
          beneficiaryMobile: '09123456789',
        ),
        OrderedVoucher(
          productSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          code: 'PRINCE',
          name: 'Prince Hypermart GC',
          description: 'A digital gift certificate that will be sent',
          unitPrice: 1000,
          unitPriceCurrencyCode: 'PHP',
          imageUrl:
              'https://pnghq.com/wp-content/uploads/walmart-logo-transparent-png-22100282-png-png-download.png',
          quantity: 1,
          status: 'Not Redeemed',
          beneficiaryName: 'John Doe',
          beneficiaryMobile: '09123456789',
        ),
        OrderedVoucher(
          productSid: '343cf143-0e43-11e4-ba0e-0ad557dde36d',
          code: 'PRINCE',
          name: 'Prince Hypermart GC',
          description: 'A digital gift certificate that will be sent',
          unitPrice: 1000,
          unitPriceCurrencyCode: 'PHP',
          imageUrl:
              'https://pnghq.com/wp-content/uploads/walmart-logo-transparent-png-22100282-png-png-download.png',
          quantity: 1,
          status: 'Validated',
          beneficiaryName: 'John Doe',
          beneficiaryMobile: '09123456789',
        ),
      ];
      _orderedVoucher.value = orderedVoucherFromServer;
      _status.value = OrderedVoucherStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = OrderedVoucherStatus.error;
    }
  }
}
