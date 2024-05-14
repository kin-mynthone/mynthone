import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:get/get.dart';

import '../../../helpers/persistent_storage_helper.dart';

class DashboardController extends GetxController {
  static DashboardController get find => Get.find();

  final _bottomNavCurrentIndex = 0.obs;
  int get bottomNavCurrentIndex => _bottomNavCurrentIndex.value;

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  GlobalKey<InnerDrawerState> get innerDrawerKey => _innerDrawerKey;

  void setBottomNavCurrentIndexValue(int index) {
    if (index == _bottomNavCurrentIndex.value) {
      return;
    }
    _bottomNavCurrentIndex.value = index;
  }

  void toggleDrawer() {
    _innerDrawerKey.currentState?.toggle();
  }

  Future<void> signOut() async {
    // await supabase.auth.signOut();

    await PersistentStorage.clearLoginCredentials();
  }
}
