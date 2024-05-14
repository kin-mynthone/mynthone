import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../helpers/persistent_storage_helper.dart';
import '../../../repository/sign_in_repository.dart';

enum AuthStatus { unauthenticated, authenticated, error }

class AuthController extends GetxController {
  static AuthController get find => Get.find();
  final _status = AuthStatus.unauthenticated.obs;
  late Worker _statusEverWorker;

  //late Rx<User?> _supabaseUser;

  static final _box = GetStorage();

  Rx<AuthStatus> get status => _status;

  String get currentState => 'AuthController(status: ${_status.value},)';

  @override
  void onReady() {
    super.onReady();
    checkCachedAccount();
    _monitorSupabaseUser();
  }

  @override
  void onClose() {
    // _supabaseUser.close();
    _statusEverWorker.dispose();
    super.onClose();
  }

  void _monitorSupabaseUser() {
    //  _supabaseUser = Rx<User?>(supabase.auth.currentUser);
    // supabase.auth.onAuthStateChange.listen(
    //   (data) {
    //     if (data.session?.accessToken != null) {
    //       Log.printInfo('access_token: ${data.session!.accessToken}');
    //       _status.value = AuthStatus.authenticated;
    //     } else {
    //       _status.value = AuthStatus.unauthenticated;
    //     }
    //   },
    // );

    _box.listenKey('SignedInEmail', (value) {
      if (PersistentStorage.getSignedInEmail() != 'no_account') {
        _status.value = AuthStatus.authenticated;
      } else {
        _status.value = AuthStatus.unauthenticated;
      }
    });
  }

  Future<void> checkCachedAccount() async {
    if (PersistentStorage.getSignedInEmail() != 'no_account') {
      final signInAccount = await SignInRepository.signInAccount(
          email: PersistentStorage.getSignedInEmail(),
          password: PersistentStorage.getSignedInPassword());

      await PersistentStorage.setAccessToken(
        accessToken: signInAccount.accessToken,
      );

      _status.value = AuthStatus.authenticated;
    } else {
      _status.value = AuthStatus.unauthenticated;
    }
  }
}
