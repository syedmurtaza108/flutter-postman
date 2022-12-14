import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/signup/signup.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState());

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

  Future<void> signup() async {
    try {
      _loader.add(true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.email.content,
        password: state.password.content,
      );
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        _message.add(e.message!);
      } else {
        _message.add('Unexpected error occurred');
      }
    } catch (e) {
      _message.add('Unexpected error occurred');
      log(e.toString());
    }

    _loader.add(false);
  }

  @override
  Future<void> close() {
    _loader.close();
    _message.close();
    return super.close();
  }
}
