import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get find => Get.find();

  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  void setCurrentIndexValue(int index) {
    if (index == _currentIndex.value) {
      return;
    }
    _currentIndex.value = index;
  }
}
