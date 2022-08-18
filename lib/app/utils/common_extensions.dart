import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';

extension ObjectX on Object? {
  bool get isNotNull => this != null;
}

extension StringX on String {
  static const _emailRegix = r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+';
  static const _urlRegix =
      r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';

  static const _minPasswordLength = 6;

  bool isConfirmPasswordValid(String password) {
    return compareTo(password) == 0;
  }

  bool get isEmailValid {
    return RegExp(_emailRegix).hasMatch(this);
  }

  bool get isPasswordValid {
    return length >= _minPasswordLength;
  }

  bool get isUrlValid {
    return RegExp(_urlRegix).hasMatch(this);
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

  String? get urlError {
    if (isEmpty) {
      return 'This is a required field';
    }

    if (!isUrlValid) {
      return 'URL is not valid';
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

  String? get nameError {
    if (isEmpty) {
      return 'This is a required field';
    }

    if (length < 6) {
      return 'Request Name is not valid';
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
  ThemeData get theme => Theme.of(this);

  void showSnackBar(String message, {bool isError = true}) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: themeColors.errorColor,
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      duration: const Duration(seconds: 2),
      content: Text(
        message,
        style: theme.textTheme.bodyText1!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  Future<T?> showDialog<T>(Widget widget) {
    return showGeneralDialog<T>(
      context: this,
      pageBuilder: (_, __, ___) => widget,
      barrierDismissible: false,
      transitionBuilder: (_, animation, __, child) {
        return Transform.scale(
          scale: Curves.easeInOut.transform(animation.value),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
