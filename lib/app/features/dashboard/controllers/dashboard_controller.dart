import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get find => Get.find();

  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  GlobalKey<InnerDrawerState> get innerDrawerKey => _innerDrawerKey;

  void setCurrentIndexValue(int index) {
    if (index == _currentIndex.value) {
      return;
    }
    _currentIndex.value = index;
  }

  void toggleDrawer() {
    _innerDrawerKey.currentState?.toggle();
  }
}
