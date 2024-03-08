import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../app/themes/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.color = AppColors.hF6F6F6,
    this.size = 50.0,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitRing(
      color: color,
      size: size,
    );
  }
}
