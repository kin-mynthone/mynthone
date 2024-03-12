import 'package:get/get.dart';
import 'package:mynthone/app/models/debit_card_model.dart';
import 'package:mynthone/app/models/statement_model.dart';

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

  final _debitCard = <DebitCard>[].obs;
  List<DebitCard> get debitCards => _debitCard;

  final _statement = <Statement>[].obs;
  List<Statement> get statement => _statement;

  String get currentState =>
      'HomeController(status: ${_status.value},  errorMessage: ${_errorMessage.value}, announcementLength: ${_announcement.length}, debitCardLength: ${_debitCard.length}, )';

  @override
  void onInit() {
    super.onInit();
    _fetchAnnouncements();
    _fetchDebitCards();
    _fetchPreviousStatement();
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
        DebitCard(
          id: '1',
          cardName: 'My Personal Savings',
          accountNumber: '3829 0407',
          currency: '€',
          amount: '20,000.00',
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
          iconUrl: '',
          validity: '07/27',
          cvv: '124',
        ),
      ];
      _debitCard.value = debitCardsFromServer;
      _status.value = HomeStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = HomeStatus.error;
    }
  }

  Future<void> _fetchPreviousStatement() async {
    _status.value = HomeStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final previousStatementFromServer = [
        Statement(
            id: '1',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Receive',
            note: 'Transfer to savings card'),
        Statement(
            id: '2',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Transfer',
            note: 'Transfer to savings card'),
        Statement(
            id: '3',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Receive',
            note: 'Transfer to savings card'),
        Statement(
            id: '4',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Receive',
            note: 'Transfer to savings card'),
        Statement(
            id: '5',
            senderName: 'Ymes Galido',
            senderAccountNumber: '2942 1953',
            receiverName: 'Kindred Inocencio',
            receiverAccountNumber: '3829 0407',
            currency: '€',
            amount: '20,000.00',
            transactionType: 'Transfer',
            note: 'Transfer to savings card'),
      ];
      _statement.value = previousStatementFromServer;
      _status.value = HomeStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = HomeStatus.error;
    }
  }
}
