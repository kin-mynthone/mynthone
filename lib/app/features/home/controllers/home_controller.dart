import 'package:get/get.dart';
import 'package:mynthone/app/models/debit_model.dart';

import '../../../models/announcement_model.dart';

enum HomeStatus { initial, loading, succeeded, error }

class HomeController extends GetxController {
  static HomeController get find => Get.find();

  final _status = HomeStatus.initial.obs;
  Rx<HomeStatus> get status => _status;
  bool get isLoading => _status.value == HomeStatus.loading;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final _announcement = <Announcement>[].obs;
  List<Announcement> get announcement => _announcement;

  final _debitCards = <DebitCards>[].obs;
  List<DebitCards> get debitCards => _debitCards;

  String get currentState =>
      'HomeController(status: ${_status.value},  errorMessage: ${_errorMessage.value}, )';

  @override
  void onInit() {
    super.onInit();
    _fetchAnnouncements();
    _fetchDebitCards();
  }

  Future<void> _fetchAnnouncements() async {
    _status.value = HomeStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final announcementFromServer = [
        Announcement(
            id: '1',
            title: 'Invite your friends & earn rewards!',
            description: 'Earn 20 EUR for every friend that joins!',
            imageUrl: ''),
        Announcement(
            id: '2',
            title: 'Invite your friends & earn rewards!',
            description: 'Earn 20 EUR for every friend that joins!',
            imageUrl: ''),
        Announcement(
            id: '2',
            title: 'Invite your friends & earn rewards!',
            description: 'Earn 20 EUR for every friend that joins!',
            imageUrl: ''),
      ];
      _announcement.value = announcementFromServer;
      _status.value = HomeStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = HomeStatus.error;
    }
  }

  Future<void> _fetchDebitCards() async {
    _status.value = HomeStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final debitCardsFromServer = [
        DebitCards(
          id: '1',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
        DebitCards(
          id: '2',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
        DebitCards(
          id: '3',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
        DebitCards(
          id: '4',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
      ];
      _debitCards.value = debitCardsFromServer;
      _status.value = HomeStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = HomeStatus.error;
    }
  }
}
