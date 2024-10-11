import 'package:flutter/material.dart';

class ColorConstants {
  static Color lightScaffoldBackgroundColor = Color(0xFFF4F4FA);
  static Color darkScaffoldBackgroundColor = Color(0xFFF4F4FA);
  static Color secondaryAppColor = hexToColor('#22DDA6');
  static Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static Color lightGray = Color(0xFFF6F6F6);
  static Color darkGray = Color(0xFF9F9F9F);
  static Color black = Color(0xFF000000);
  static Color white = Color(0xFFFFFFFF);

  static const primaryColor = Color(0xFF5B67CA);
  static const primaryColorDark = Color(0xFF5B67CA);
  static const primaryColorLight = Color(0xFFF48FB1);
  static const primaryColorAccent = Color(0xFFFFEB3B);

  static const secondaryColor = Color(0xFF5B67CA);
  static const secondaryColorDark = Color(0xFF5B67CA);
  static const secondaryColorLight = Color(0xFFD1C4E9);
  static const secondaryColorAccent = Color(0xFF03A9F4);

  static const backgroundColor = Color(0xFFFAFAFA);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
