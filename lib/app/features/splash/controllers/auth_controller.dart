import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../instances/firebase_service_instances.dart';

enum AuthStatus { unauthenticated, authenticated, error }

class AuthController extends GetxController {
  static AuthController get find => Get.find();
  final _status = AuthStatus.unauthenticated.obs;
  late Worker _statusEverWorker;

  late Rx<User?> _firebaseUser;

  Rx<AuthStatus> get status => _status;

  String get currentState =>
      'AuthController(status: ${_status.value}, firebaseUser: ${_firebaseUser.value})';

  @override
  void onReady() {
    super.onReady();
    _monitorFirebaseUser();
  }

  @override
  void onClose() {
    _firebaseUser.close();
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorFirebaseUser() {
    _firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    _firebaseUser.bindStream(firebaseAuth.idTokenChanges());
    ever(_firebaseUser, (User? value) {
      if (value != null) {
        _status.value = AuthStatus.authenticated;
      } else {
        _status.value = AuthStatus.unauthenticated;
      }
    });
  }
}
