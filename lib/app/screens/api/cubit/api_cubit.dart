import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:json_to_dart/json_to_dart.dart';
import 'package:uuid/uuid.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiState());

  final _loader = StreamController<bool>.broadcast();
  Stream<bool> get loader => _loader.stream;

  final _message = StreamController<String>.broadcast();
  Stream<String> get message => _message.stream;

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
    _loader.add(true);
    try {
      final url = Uri.parse(state.url.content).replace(
        queryParameters: state.params,
      );
      final http.Response response;

      switch (state.type) {
        case HttpMethod.get:
          response = await _httpClient.get(url);
          break;
        case HttpMethod.post:
          response = await _httpClient.post(url, body: state.body);
          break;
        case HttpMethod.put:
          response = await _httpClient.put(url, body: state.body);
          break;
        case HttpMethod.patch:
          response = await _httpClient.patch(url, body: state.body);
          break;
        case HttpMethod.delete:
          response = await _httpClient.delete(url);
          break;
      }
      emit(
        state.copyWith(
          response: response.body,
          dartCode: response.body.isNotEmpty
              ? ModelGenerator('ApiResponse')
                  .generateDartClasses(
                    response.body.isEmpty || response.body.trim() == '{}'
                        ? '{"Name":""}'
                        : response.body,
                  )
                  .code
              : '',
        ),
      );
    } catch (e) {
      log(e.toString());
      _message.add(e.toString());
    }
    _loader.add(false);
  }

  Future<void> save() async {
    await FirebaseFirestore.instance.collection('apis').add(state.toMap());
  }

  List<JsonFieldState> get headers {
    final list = <JsonFieldState>[];
    state.headers.forEach(
      (key, value) {
        list.add(
          JsonFieldState(
            id: const Uuid().v1(
              options: {
                'mSecs': DateTime.now().millisecondsSinceEpoch,
              },
            ),
            key: key,
            value: value,
          ),
        );
      },
    );
      list.add(
        JsonFieldState(
          id: const Uuid().v1(
            options: {
              'mSecs': DateTime.now().millisecondsSinceEpoch,
            },
          ),
        ),
      );
    
    return list;
  }

  List<JsonFieldState> get params {
    final list = <JsonFieldState>[];
    state.params.forEach(
      (key, value) {
        list.add(
          JsonFieldState(
            id: const Uuid().v1(
              options: {
                'mSecs': DateTime.now().millisecondsSinceEpoch,
              },
            ),
            key: key,
            value: value,
          ),
        );
      },
    );
    list.add(
        JsonFieldState(
          id: const Uuid().v1(
            options: {
              'mSecs': DateTime.now().millisecondsSinceEpoch,
            },
          ),
        ),
      );
    return list;
  }

  @override
  Future<void> close() {
    _loader.close();
    _message.close();
    return super.close();
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
