import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

enum NetworkControllerStatus { online, offline }

class NetworkController extends GetxController {
  static NetworkController get find => Get.find();

  final _status = NetworkControllerStatus.offline.obs;
  Rx<NetworkControllerStatus> get status => _status;

  final _checkConnectivityResult = false.obs;
  bool get checkConnectivityResult => _checkConnectivityResult.value;

  String get currentState => 'NetworkController(status: ${_status.value})';

  @override
  void onInit() {
    super.onInit();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _checkConnectivityResult.value = false;
        _status.value = NetworkControllerStatus.offline;
      } else {
        _checkConnectivityResult.value = true;
        _status.value = NetworkControllerStatus.online;
      }
    });
  }
}
