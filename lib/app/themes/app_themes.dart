import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_numbers.dart';
import 'app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch: AppColors.materialSteelBlue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.hE06144,
      secondary: AppColors.h2445D4,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.h403E51,
            height: 1.2),
      ),

      titleMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: AppColors.h403E51,
            height: 1.2),
      ),

      //------

      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: AppColors.h403E51,
        ),
      ),

      bodyMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: AppColors.h403E51,
            height: 1.2),
      ),

      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: AppColors.h403E51,
            height: 1.2),
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.hF6F6F6,
      labelStyle: const TextStyle(
        color: AppColors.hBDBDBD,
        fontSize: 13,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColors.h2445D4,
        fontSize: 13,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
        borderSide: const BorderSide(color: AppColors.h2445D4, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
        borderSide: const BorderSide(color: AppColors.hD0D0D0, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
        borderSide: const BorderSide(color: AppColors.hF14C4C, width: 1.0),
      ),
      errorStyle: const TextStyle(fontSize: 10),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
        borderSide: const BorderSide(
          color: AppColors.hF14C4C,
          width: 2.0,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.hE06144,
        foregroundColor: AppColors.hFFF8F8,
        elevation: 0,
        minimumSize: const Size(
          double.infinity,
          45,
        ),
        textStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: AppColors.hF6F6F6,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primarySwatch: AppColors.materialSteelBlue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.hE06144,
      secondary: AppColors.h2445D4,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.acmeTextTheme(),
  );
}
