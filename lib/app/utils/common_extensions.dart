import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

extension ObjectX on Object? {
  bool get isNotNull => this != null;
}

extension AutoSizeTextX on AutoSizeText {
  AutoSizeText withColor(Color color) => AutoSizeText(
        data ?? '',
        style: style?.copyWith(color: color),
        maxLines: maxLines,
        textAlign: textAlign,
      );
  AutoSizeText withFont(double size) => AutoSizeText(
        data ?? '',
        style: style?.copyWith(fontSize: size),
        maxLines: maxLines,
        textAlign: textAlign,
      );
  AutoSizeText get bold => AutoSizeText(
        data ?? '',
        style: style?.copyWith(fontWeight: FontWeight.bold),
        maxLines: maxLines,
        textAlign: textAlign,
      );
  AutoSizeText withMaxLines(int lines) => AutoSizeText(
        data ?? '',
        style: style,
        maxLines: lines,
        textAlign: textAlign,
      );
}

extension StringX on String {
  static const _emailRegix = r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+';

  static const _minPasswordLength = 6;

  AutoSizeText get body1 => AutoSizeText(
        this,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: AppFonts.roboto,
        ),
        maxLines: 2,
        textAlign: TextAlign.center,
      );

  AutoSizeText get body2 => AutoSizeText(
        this,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontFamily: AppFonts.roboto,
        ),
        maxLines: 2,
        textAlign: TextAlign.center,
      );

  bool isConfirmPasswordValid(String password) {
    return compareTo(password) == 0;
  }

  bool get isEmailValid {
    return RegExp(_emailRegix).hasMatch(this);
  }

  bool get isPasswordValid {
    return length >= _minPasswordLength;
  }

  String? get emailError {
    if (isEmpty) {
      return 'This is a required field';
    }

    if (!isEmailValid) {
      return 'Email is not valid';
    }

    return null;
  }

  String? get passwordError {
    if (isEmpty) {
      return 'This is a required field';
    }

    if (!isPasswordValid) {
      return 'Password is not valid';
    }

    return null;
  }

  String? toConfirmPasswordError(String pass2) {
    if (isEmpty) {
      return 'This is a required field';
    }

    if (!isConfirmPasswordValid(pass2)) {
      return 'Passwords do not match';
    }

    return null;
  }
}

extension NumX on num {
  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get height => SizedBox(height: toDouble());
  EdgeInsets get padding => EdgeInsets.all(toDouble());
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
  BorderRadius get border => BorderRadius.circular(toDouble());
}

extension ContextX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  NavigatorState get navigator => Navigator.of(this);
}
