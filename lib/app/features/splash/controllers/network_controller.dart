import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  static NetworkController get find => Get.find();

  final _checkConnectivityResult = false.obs;
  bool get checkConnectivityResult => _checkConnectivityResult.value;

  @override
  void onInit() {
    super.onInit();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _checkConnectivityResult.value = false;
      } else {
        _checkConnectivityResult.value = true;
      }
    });
  }
}
