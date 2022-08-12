import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/models/models.dart';
import 'package:flutter_postman/app/screens/login/login.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(email: FormField(), password: FormField()));

  final _loader = StreamController<bool>.broadcast();
  Stream<bool> get loader => _loader.stream;

  final _message = StreamController<String>.broadcast();
  Stream<String> get message => _message.stream;

  void onEmailChanged(String email) {
    emit(
      state.copyWith(
        email: state.email.copyWith(
          content: email.trim(),
          error: email.trim().emailError,
        ),
      ),
    );
    _enableNext();
  }

  void onPasswordChanged(String password) {
    emit(
      state.copyWith(
        password: state.password.copyWith(
          content: password.trim(),
          error: password.trim().passwordError,
        ),
      ),
    );
    _enableNext();
  }

  void _enableNext({bool isLoading = false}) {
    emit(state.copyWith(enableNext: state.isFormValid && !isLoading));
  }

  Future<void> login() async {
    // _loader.add(true);
    // await Future.delayed(const Duration(seconds: 5), () {});
    // _loader.add(false);
    _message.add('Hello');
  }

  @override
  Future<void> close() {
    _loader.close();
    _message.close();
    return super.close();
  }
}
