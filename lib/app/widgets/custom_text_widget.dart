import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynthone/app/themes/app_colors.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final bool overflow;
  final double letterSpacing;
  final double heightValue;

  final Color color;
  final bool centerAlignment;

  const CustomTextWidget(
      {super.key,
      required this.text,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal,
      this.color = AppColors.h425AC2,
      this.centerAlignment = false,
      this.letterSpacing = 0,
      this.overflow = false,
      this.heightValue = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      overflow: overflow ? TextOverflow.ellipsis : null,
      style: GoogleFonts.poppins(
          fontSize: fontSize,
          color: color,
          letterSpacing: letterSpacing,
          height: heightValue,
          fontWeight: fontWeight),
      textAlign: centerAlignment ? TextAlign.center : TextAlign.left,
    );
  }
}
