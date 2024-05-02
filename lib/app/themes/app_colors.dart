import 'package:flutter/material.dart';

class AppColors {
  static const Color hE06144 = Color(0xFFE06144); //primary
  static const Color hFFF8F8 = Color(0xFFFFF8F8); //primary light
  static const Color h2445D4 = Color(0xFF2445D4); //secondary
  static const Color hA4B8EA = Color(0xFFA4B8EA); //secondary light

  static const Color h403E51 = Color(0xFF403E51); //text
  static const Color h8E8E8E = Color(0xFF8E8E8E); //sub text

  static const Color hF6F6F6 = Color(0xFFF6F6F6); //white variant
  static const Color hBDBDBD = Color(0xFFBDBDBD); //inputForm label
  static const Color hD0D0D0 = Color(0xFFD0D0D0); //inputForm border
  static const Color hE8E8E8 = Color(0xFFE8E8E8); //page indicator
  static const Color hF2F4FE = Color(0xFFF2F4FE); //announcement cards

  static const Color hF14C4C = Color(0xFFF14C4C); //negative
  static const Color h1BBE49 = Color(0xFF1BBE49); //positive

  static const Color hE5EAFF = Color(0xFFE5EAFF); //navbar inactive

  static Color barrierColor = Colors.black.withOpacity(0.80); //overlay

  static const Map<int, Color> _steelBlueColorMap = {
    50: Color.fromRGBO(63, 125, 178, .1),
    100: Color.fromRGBO(63, 125, 178, .2),
    200: Color.fromRGBO(63, 125, 178, .3),
    300: Color.fromRGBO(63, 125, 178, .4),
    400: Color.fromRGBO(63, 125, 178, .5),
    500: Color.fromRGBO(63, 125, 178, .6),
    600: Color.fromRGBO(63, 125, 178, .7),
    700: Color.fromRGBO(63, 125, 178, .8),
    800: Color.fromRGBO(63, 125, 178, .9),
    900: Color.fromRGBO(63, 125, 178, 1),
  };

  static const MaterialColor materialSteelBlue =
      MaterialColor(0xFFE06144, _steelBlueColorMap);
}
