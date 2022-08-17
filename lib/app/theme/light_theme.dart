import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class AppTheme {
  AppTheme._();

  static const _colorScheme = ColorScheme(
    primary: AppColors.black300,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: AppColors.black400,
    surface: Colors.white,
    onSurface: AppColors.black400,
    background: AppColors.black300,
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  static final _textTheme = TextTheme(
    headline1: TextStyle(
      fontFamily: AppFonts.roboto,
      color: _colorScheme.onBackground,
      fontSize: 22,
    ),
    headline2: TextStyle(
      fontFamily: AppFonts.roboto,
      color: _colorScheme.primary,
      fontSize: 18,
    ),
    headline3: TextStyle(
      fontFamily: AppFonts.roboto,
      color: _colorScheme.onBackground,
      fontSize: 18,
    ),
    subtitle1: TextStyle(
      fontFamily: AppFonts.roboto,
      color: _colorScheme.onBackground,
      fontSize: 16,
    ),
    subtitle2: TextStyle(
      fontFamily: AppFonts.roboto,
      color: _colorScheme.onBackground,
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      fontFamily: AppFonts.roboto,
      color: _colorScheme.onBackground,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    caption: TextStyle(
      fontFamily: AppFonts.roboto,
      color: _colorScheme.onBackground,
      fontSize: 12,
    ),
  );

  static final _buttonTheme2 = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 8,
      primary: _colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      textStyle: const TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.roboto,
        fontWeight: FontWeight.bold,
      ),
      splashFactory: InkRipple.splashFactory,
    ),
  );

  static final _progressBarTheme = ProgressIndicatorThemeData(
    color: _colorScheme.primary,
    circularTrackColor: _colorScheme.background,
    linearTrackColor: _colorScheme.background,
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    fillColor: Color(0xff262a2f),
    errorMaxLines: 2,
    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    filled: true,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: _colorScheme,
      primaryColor: _colorScheme.primary,
      errorColor: _colorScheme.error,
      scaffoldBackgroundColor: _colorScheme.background,
      textTheme: _textTheme,
      elevatedButtonTheme: _buttonTheme2,
      inputDecorationTheme: _inputDecorationTheme,
      progressIndicatorTheme: _progressBarTheme,
      dialogBackgroundColor: _colorScheme.background,
      unselectedWidgetColor: const Color(0xff5a6670),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
    );
  }
}
