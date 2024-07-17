import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DepositInstructionStatus { initial, loading, finished, error }

class DepositInstructionController extends GetxController {
  static DepositInstructionController get find => Get.find();

  late PageController _pageController;
  PageController get pageController => _pageController;

  final _status = DepositInstructionStatus.initial.obs;
  Rx<DepositInstructionStatus> get status => _status;
  bool get isLoading => _status.value == DepositInstructionStatus.loading;

  final _currentPage = 0.obs;
  int get currentPage => _currentPage.value;

  String get currentState =>
      'DepositInstructionController(status: ${_status.value})';

  @override
  void onInit() {
    super.onInit();
    _pageController = PageController();
    _pageController.addListener(_getCurrentPageIndex);
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  void goToNextView() {
    if (_currentPage.value != 5) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else {
      Get.back(closeOverlays: true);
    }
  }

  void _getCurrentPageIndex() {
    _currentPage.value =
        _pageController.page?.round() ?? _pageController.initialPage;
  }
}
