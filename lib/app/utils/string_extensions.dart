import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

extension StringX on String {
  static const _emailRegix = r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+';

  static const _minPasswordLength = 6;

  Text get body1 => Text(
        this,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: AppFonts.roboto,
        ),
      );

  Text get body2 => Text(
        this,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontFamily: AppFonts.roboto,
        ),
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
