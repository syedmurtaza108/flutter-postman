import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiState());

  void onUrlChanged(String url) {
    emit(
      state.copyWith(
        url: state.url.copyWith(
          content: url.trim(),
          error: url.trim().urlError,
        ),
      ),
    );
    _enableSend();
  }

  void _enableSend({bool isLoading = false}) {
    emit(state.copyWith(enableSend: state.isFormValid && !isLoading));
  }

  void showNameEdit() {
    emit(state.copyWith(showNameEdit: true));
  }

  void hideNameEdit() {
    emit(state.copyWith(showNameEdit: false));
  }
}
