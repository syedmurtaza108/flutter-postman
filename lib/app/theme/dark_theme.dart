import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class DarkTheme {
  DarkTheme._();

  static const _textTheme = TextTheme(
    headline1: TextStyle(
      fontFamily: AppFonts.roboto,
      color: Colors.white,
      fontSize: 22,
    ),
    headline2: TextStyle(
      fontFamily: AppFonts.roboto,
      color: Colors.white,
      fontSize: 18,
    ),
    headline3: TextStyle(
      fontFamily: AppFonts.roboto,
      color: Colors.white,
      fontSize: 18,
    ),
    subtitle1: TextStyle(
      fontFamily: AppFonts.roboto,
      color: Colors.white,
      fontSize: 16,
    ),
    subtitle2: TextStyle(
      fontFamily: AppFonts.roboto,
      color: Colors.white,
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      fontFamily: AppFonts.roboto,
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    caption: TextStyle(
      fontFamily: AppFonts.roboto,
      color: Colors.white,
      fontSize: 12,
    ),
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    fillColor: Color(0xff262a2f),
    errorMaxLines: 2,
    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    filled: true,
  );

  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      unselectedWidgetColor: const Color(0xff5a6670),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
    );
  }
}
