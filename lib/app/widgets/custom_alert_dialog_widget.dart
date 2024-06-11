import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  const CustomAlertDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onPressed,
  });

  final String title;
  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onPressed();
            },
            child: Text('Continue'.tr),
          ),
        ],
      ),
    );
  }
}
