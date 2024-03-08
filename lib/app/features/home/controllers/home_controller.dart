import 'package:get/get.dart';

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

  String get currentState =>
      'HomeController(status: ${_status.value},  errorMessage: ${_errorMessage.value}, )';

  @override
  void onInit() {
    super.onInit();
    _fetchAnnouncement();
  }

  Future<void> _fetchAnnouncement() async {
    _status.value = HomeStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final eventsFromServer = [
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
      _announcement.value = eventsFromServer;
      _status.value = HomeStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = HomeStatus.error;
    }
  }
}
