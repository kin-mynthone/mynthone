import 'package:flutter/material.dart';

class AppColors {
  static const Color h3F7DB2 = Color(0xFF3F7DB2);
  static const Color h9EC6DC = Color(0xFF9EC6DC);
  static const Color h031223 = Color(0xFF031223);
  static const Color hF6F6F6 = Color(0xFFF6F6F6);
  static const Color hBDBDBD = Color(0xFFBDBDBD);
  static const Color hEEEEEE = Color(0xFFEEEEEE);

  static Color barrierColor = Colors.black.withOpacity(0.80);

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
      MaterialColor(0xFF3F7DB2, _steelBlueColorMap);
}
