import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../instances/supabase_service_instances.dart';

enum AuthStatus { unauthenticated, authenticated, error }

class AuthController extends GetxController {
  static AuthController get find => Get.find();
  final _status = AuthStatus.unauthenticated.obs;
  late Worker _statusEverWorker;

  late Rx<User?> _supabaseUser;

  Rx<AuthStatus> get status => _status;

  String get currentState =>
      'AuthController(status: ${_status.value}, supabaseUser: ${_supabaseUser.value})';

  @override
  void onReady() {
    super.onReady();
    _monitorSupabaseUser();
  }

  @override
  void onClose() {
    _supabaseUser.close();
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorSupabaseUser() {
    _supabaseUser = Rx<User?>(supabase.auth.currentUser);
    supabase.auth.onAuthStateChange.listen(
      (data) {
        if (data.session?.accessToken != null) {
          _status.value = AuthStatus.authenticated;
        } else {
          _status.value = AuthStatus.unauthenticated;
        }
      },
    );
  }
}
