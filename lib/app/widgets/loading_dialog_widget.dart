import 'package:flutter/material.dart';

import 'loading_indicator_widget.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Center(child: LoadingIndicator(color: Colors.white)),
      ),
    );
  }
}
