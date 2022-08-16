import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:http/http.dart' as http;

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiState());

  void onNameChanged(String name) {
    emit(
      state.copyWith(
        name: state.name.copyWith(
          content: name.trim(),
          error: name.trim().nameError,
        ),
      ),
    );
    _enableSend();
  }

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

  Future<void> send() async {
    try {
      final url = Uri.parse(state.url.content);
      final response =
          await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      print(await http.read(Uri.https('example.com', 'foobar.txt')));
    } catch (e) {}
  }
}
