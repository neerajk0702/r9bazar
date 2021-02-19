import 'package:flutter/material.dart';
import 'package:rbazaar/utils/mycolors.dart';

class DarkTheme {
  static const String AppFont = "Karla";
  static ThemeData darkTheme() =>  ThemeData(
    backgroundColor: Colors.black,
    primaryColor: MyColors.primaryColor,
    accentColor: MyColors.primaryColor,
    buttonColor: MyColors.primaryColor,
    cardColor: MyColors.primaryColor,
    indicatorColor: MyColors.primaryColor,
    cursorColor: Colors.white,
    textTheme: TextTheme(
    body1: TextStyle(
        fontFamily: AppFont,  fontSize: 14),
    body2: TextStyle(
      fontFamily: AppFont,
      color: MyColors.darkgrey_60,
      fontSize: 12,
    ),
    button: TextStyle(
      fontFamily: AppFont,
      color: Colors.white,
      fontSize: 20.0,
    ),
    display1: TextStyle(
        fontFamily: AppFont, color: Colors.black, fontSize: 20),
    display2: TextStyle(
        fontFamily: AppFont, color: MyColors.darkgrey_60, fontSize: 16),
    display3: TextStyle(
        fontFamily: AppFont, color:MyColors.darkgrey_60, fontSize: 18),
    display4: TextStyle(
        fontFamily: AppFont,
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold),
    caption: TextStyle(
        fontFamily: AppFont, color: MyColors.darkgrey_60, fontSize: 14),
    overline: TextStyle(fontFamily: AppFont, color: Colors.white, fontSize: 16),
    headline: TextStyle(
        fontFamily: AppFont,
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold),
    subhead: TextStyle(fontFamily: AppFont),
    subtitle: TextStyle(fontFamily: AppFont),
    title: TextStyle(
      fontFamily: AppFont,
      color: MyColors.darkgrey_60,
      fontSize: 25,
    ),
  ),
  );
}
