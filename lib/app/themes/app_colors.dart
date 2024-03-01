import 'package:flutter/material.dart';

class AppColors {
  static const Color hF87054 = Color(0xFFF87054); //primary
  static const Color hFFF8F8 = Color(0xFFFFF8F8); //primary light
  static const Color h425AC2 = Color(0xFF425AC2); //secondary
  static const Color hA4B8EA = Color(0xFFA4B8EA); //secondary light

  static const Color h403E51 = Color(0xFF403E51); //text
  static const Color h8E8E8E = Color(0xFF8E8E8E); //sub text

  static const Color hF6F6F6 = Color(0xFFF6F6F6); //white variant
  static const Color hBDBDBD = Color(0xFFBDBDBD); //inputForm label
  static const Color hD0D0D0 = Color(0xFFD0D0D0); //inputForm border

  static const Color h7CD0AD = Color(0xFF7CD0AD); //positive

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
      MaterialColor(0xFFF87054, _steelBlueColorMap);
}
