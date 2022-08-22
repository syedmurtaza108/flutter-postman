import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_postman/app/models/models.dart';

class ApiState {
  ApiState({
    this.name = const FormField(content: 'UNTITLED REQUEST'),
    this.type = 'GET',
    this.url = const FormField(),
    this.params = const <String, String>{},
    this.headers = const <String, String>{},
    this.body,
    this.enableSend = false,
    this.showNameEdit = false,
    this.response = '',
    this.dartCode = '',
  });

  final FormField name;
  final String type;
  final FormField url;
  final Map<String, String> headers;
  final Map<String, String> params;
  final dynamic body;
  final bool enableSend;
  final bool showNameEdit;
  final String response;
  final String dartCode;

  bool get isFormValid {
    return name.error == null && url.error == null;
  }

  ApiState copyWith({
    FormField? name,
    String? type,
    FormField? url,
    Map<String, String>? params,
    Map<String, String>? headers,
    dynamic body,
    bool? enableSend,
    bool? showNameEdit,
    String? response,
    String? dartCode,
  }) {
    return ApiState(
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      params: params ?? this.params,
      headers: headers ?? this.headers,
      body: body ?? this.body,
      enableSend: enableSend ?? this.enableSend,
      showNameEdit: showNameEdit ?? this.showNameEdit,
      dartCode: dartCode ?? this.dartCode,
      response: response ?? this.response,
    );
  }

  Map<String, dynamic> toMap() {
    var bodyStr = body;
    try {
      bodyStr = jsonDecode(body.toString());
    } catch (e) {
      log(e.toString());
    }
    return {
      'name': name.content,
      'type': type,
      'url': url.content,
      'headers': headers,
      'params': params,
      'body': bodyStr,
      'response': response,
      'code': dartCode,
      'userId': FirebaseAuth.instance.currentUser?.uid,
    };
  }
}
