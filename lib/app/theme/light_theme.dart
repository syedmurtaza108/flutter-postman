import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class LightTheme extends ThemeColors {
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

  static final _inputDecorationTheme = InputDecorationTheme(
    fillColor: themeColors.textFieldBackColor,
    errorMaxLines: 2,
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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

  @override
  Color get componentBackColor => AppColors.darkGunmetal;

  @override
  Color get textIconButtonBorderColor => AppColors.cadet;

  @override
  Color get headingTextColor => AppColors.lightGray;

  @override
  Color get errorColor => AppColors.fireOpal;

  @override
  Color get dashboardTopContainerColor => AppColors.gunmetal;

  @override
  Color get pageBackColor => AppColors.eerieBlack;

  @override
  Color get userNameBackColor => AppColors.outerSpaceCrayola;

  @override
  Color get authCardBackColor => AppColors.metallicBlue;

  @override
  Color get textButtonFrontColor => AppColors.chineseBlue;

  @override
  Color get loginNavigationHintColor => AppColors.romanSilver;

  @override
  Color get noButtonBackColor => AppColors.auroMetalSaurus;

  @override
  Color get logoDotColor => AppColors.chineseYellow;

  @override
  Color get buttonColor => AppColors.paoloVeroneseGreen;

  @override
  Color get textFieldBackColor => AppColors.charlestonGreen;
}
