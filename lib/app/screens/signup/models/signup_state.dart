import 'package:flutter_postman/app/models/models.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class SignupState {
  SignupState({
    this.email = const FormField(),
    this.password = const FormField(),
    this.enableNext = false,
  });

  final FormField email;
  final FormField password;
  final bool enableNext;

  bool get isFormValid {
    return email.content.isEmailValid && password.content.isPasswordValid;
  }

  SignupState copyWith({
    FormField? email,
    FormField? password,
    bool? enableNext,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      enableNext: enableNext ?? this.enableNext,
    );
  }
}
