import 'package:get/get.dart';

import '../../../models/debit_card_model.dart';

enum HomeCardStatus { initial, loading, succeeded, error }

class HomeCardController extends GetxController {
  static HomeCardController get find => Get.find();

  final _status = HomeCardStatus.initial.obs;
  Rx<HomeCardStatus> get status => _status;
  bool get isLoading => _status.value == HomeCardStatus.loading;

  final _debitCard = <DebitCard>[].obs;
  List<DebitCard> get debitCards => _debitCard;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'HomeCardController(status: ${_status.value},  errorMessage: ${_errorMessage.value},  debitCardLength: ${_debitCard.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchDebitCards();
  }

  Future<void> _fetchDebitCards() async {
    _status.value = HomeCardStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final debitCardsFromServer = [
        DebitCard(
          id: '1',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
          color: '',
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
        DebitCard(
          id: '2',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
          color: '',
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
        DebitCard(
          id: '3',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
          color: '',
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
        DebitCard(
          id: '4',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
          color: '',
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
      ];
      _debitCard.value = debitCardsFromServer;
      _status.value = HomeCardStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = HomeCardStatus.error;
    }
  }
}
