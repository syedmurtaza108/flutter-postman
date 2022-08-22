import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:http/http.dart' as http;

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiState());

  final _httpClient = CustomHttpClient(http.Client());

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

  void onMethodChanged(HttpMethod method) {
    emit(state.copyWith(type: method));
  }

  void onBodyChanged(dynamic body) {
    emit(state.copyWith(body: body.toString()));
  }

  void onHeadersChanged(Map<String, String> headers) {
    emit(state.copyWith(headers: headers));
  }

  void onParamsChanged(Map<String, String> params) {
    emit(state.copyWith(params: params));
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
      dynamic body = state.body;
      if (state.body != null) {
        body = jsonDecode(state.body.toString());
      }
      await _httpClient.post(url, body: body);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> save() async {
    await FirebaseFirestore.instance.collection('apis').add(state.toMap());
  }
}

class CustomHttpClient extends http.BaseClient {
  CustomHttpClient(this._client);
  final http.Client _client;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _client.send(request);
    final bytes = await response.stream.toBytes();
    dynamic responseBody = '';

    try {
      final a = utf8.decode(bytes);
      responseBody = jsonDecode(a);
    } catch (e) {
      log(e.toString());
    }

    print(responseBody);
    return http.StreamedResponse(
      http.ByteStream.fromBytes(bytes),
      response.statusCode,
    );
  }
}
