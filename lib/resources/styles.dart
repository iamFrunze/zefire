import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// class for colors that are not present in default Themedata
class CustomColors {
  static Color shadowColorDark = Color.fromRGBO(33, 28, 28, 0.6);
  static Color shadowColorLight = Color.fromRGBO(0, 0, 0, 0.4);
}

class CustomStyles {
  static BoxShadow shadowDecorationDark = BoxShadow(
      color: CustomColors.shadowColorDark,
      spreadRadius: 0,
      blurRadius: 16,
      offset: Offset(-9, -9));

  static BoxShadow shadowDecorationLight = BoxShadow(
      color: CustomColors.shadowColorLight,
      spreadRadius: 0,
      blurRadius: 16,
      offset: Offset(9, 9));

  static double spacingBig = 24.0;

  static double spacingSmall = 16.0;

  static double smallDeviceWidthMax = 330;

  static double spacingBigSmallScreen = 16.0;

  static double spacingSmallSmallScreen = 8.0;

  static TextStyle headline1SmallScreen(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: 14.0); // was 17
  }

  static TextStyle headline2SmallScreen(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline2
        .copyWith(fontSize: 14.0); // was 16
  }

  static TextStyle bodyText1SmallScreen(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontSize: 12.0); // was 16
  }

  static TextStyle bodyText2SmallScreen(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontSize: 16.0); // was 24
  }

  static TextStyle buttonSmallScreen(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .button
        .copyWith(fontSize: 14.0); // was 16
  }

  static ThemeData customTheme = ThemeData(
    primaryColor: Color.fromRGBO(255, 69, 58, 1),
    backgroundColor: Color.fromRGBO(28, 28, 30, 1),
    disabledColor: Color.fromRGBO(44, 44, 46, 1),
    primaryColorDark: Color.fromRGBO(168, 7, 26, 1),
    dividerColor: Color.fromRGBO(56, 56, 58, 1),
    fontFamily: "Montserrat",
    textTheme: TextTheme(
      headline1: TextStyle(
          // system status and power view title
          color: Colors.white,
          fontSize: 17.0,
          height: 1.1,
          fontWeight: FontWeight.w600),
      headline2: TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      bodyText1: TextStyle(
          // power status text
          color: Colors.white,
          fontSize: 16.0,
          height: 1.2,
          fontWeight: FontWeight.w400),
      bodyText2: TextStyle(
          // fuelvolume percentage
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w600),
      button: TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      subtitle1: TextStyle(
          // flame buttons text
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w600),
      subtitle2: TextStyle(
          color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400),
    ),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
