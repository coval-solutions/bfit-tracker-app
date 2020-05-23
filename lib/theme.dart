import 'package:flutter/material.dart';

final ThemeData mainTheme = ThemeData(
  primaryColor: CustomColor.SELECTIVE_YELLOW,
  accentColor: CustomColor.MAYA_BLUE,
  backgroundColor: CustomColor.ALICE_BLUE,
  disabledColor: CustomColor.MAYA_BLUE,
  fontFamily: 'SF UI Text',
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class CustomColor {
  // Color names obtained from htmlcsscolor.com
  static const Color DIM_GRAY = Color(0xff707070);
  static const Color GREY_CHATEAU = Color(0xff9E9FA1);
  static const Color SELECTIVE_YELLOW = Color(0xffFFB300);
  static const Color LAVENDER = Color(0xffE5E5E6);
  static const Color MAYA_BLUE = Color(0xff6EC6FF);
  static const Color MEDIUM_ORCHID = Color(0xffB158CC);
  static const Color ALICE_BLUE = Color(0xffF4F5F6);
}
