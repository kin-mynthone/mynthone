import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/log_helper.dart';
import '../../../widgets/loading_indicator_widget.dart';
import '../controllers/auth_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final authController = AuthController.find;
  late Worker _authStatusWorker;

  @override
  void initState() {
    super.initState();
    _setUpAuthStatusWorker();
  }

  @override
  void dispose() {
    _authStatusWorker.dispose();
    super.dispose();
  }

  void _setUpAuthStatusWorker() {
    _authStatusWorker = ever(authController.status, (value) {
      if (value == AuthStatus.error) {
        Log.printInfo(authController.currentState);
      }
      if (value == AuthStatus.unauthenticated) {
        Log.printInfo(authController.currentState);
        //TODO: Add page here
      }
      if (value == AuthStatus.authenticated) {
        Log.printInfo(authController.currentState);
        //TODO: Add page here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: LoadingIndicator(),
        ),
      ),
    );
  }
}
