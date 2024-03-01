import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_numbers.dart';
import 'app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch: AppColors.materialSteelBlue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.h3F7DB2,
      secondary: AppColors.h9EC6DC,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.h031223,
        ),
      ),
      bodyMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.h031223,
        ),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.h031223,
        ),
      ),
      labelLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      displaySmall: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.hF6F6F6,
      labelStyle: const TextStyle(color: AppColors.hBDBDBD),
      floatingLabelStyle: const TextStyle(color: AppColors.h3F7DB2),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
        borderSide: const BorderSide(color: AppColors.h3F7DB2, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
        borderSide: const BorderSide(color: AppColors.hEEEEEE, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
        borderSide: const BorderSide(color: Colors.red, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppNumbers.inputBorderRadius),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.h3F7DB2,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
        textStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primarySwatch: AppColors.materialSteelBlue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.h3F7DB2,
      secondary: AppColors.h9EC6DC,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.acmeTextTheme(),
  );
}
