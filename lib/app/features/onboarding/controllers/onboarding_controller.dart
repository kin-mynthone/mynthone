import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/persistent_storage_helper.dart';

enum OnboardingStatus { initial, loading, finished, error }

class OnboardingController extends GetxController {
  static OnboardingController get find => Get.find();

  late PageController _pageController;
  PageController get pageController => _pageController;

  final _status = OnboardingStatus.initial.obs;
  Rx<OnboardingStatus> get status => _status;
  bool get isLoading => _status.value == OnboardingStatus.loading;

  String get currentState => 'OnboardingController(status: ${_status.value})';

  @override
  void onInit() {
    super.onInit();
    _pageController = PageController();
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  void goToNextView() {
    if (getCurrentPageIndex(_pageController) != 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else {
      finishOnboarding();
    }
  }

  int getCurrentPageIndex(PageController controller) {
    return controller.page?.round() ?? controller.initialPage;
  }

  Future<void> finishOnboarding() async {
    _status.value = OnboardingStatus.loading;
    try {
      await PersistentStorage.setIsDoneWithOnboardingKey(true);
      _status.value = OnboardingStatus.finished;
    } catch (e) {
      _status.value = OnboardingStatus.error;
    }
  }
}
