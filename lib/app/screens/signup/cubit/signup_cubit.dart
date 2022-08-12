import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/models/models.dart';
import 'package:flutter_postman/app/screens/signup/signup.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState(email: FormField(), password: FormField()));

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
      if (e.code == 'weak-password') {
        _message.add('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _message.add('The account already exists for this email.');
      }
    } catch (e) {
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
