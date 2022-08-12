import 'package:flutter_postman/app/models/models.dart';

class ApiState {
  ApiState({
    this.name = const FormField(),
    this.type = 'GET',
    this.url = const FormField(),
    this.params = const <String, String>{},
    this.authorization = const FormField(),
    this.body = '',
    this.enableNext = false,
  });

  final FormField name;
  final String type;
  final FormField url;
  final Map<String, String> params;
  final FormField authorization;
  final dynamic body;
  final bool enableNext;

  bool get isFormValid {
    return name.content.isNotEmpty && url.content.isNotEmpty;
  }

  ApiState copyWith({
    final FormField? name,
    final String? type,
    final FormField? url,
    final Map<String, String>? params,
    final FormField? authorization,
    final dynamic body,
    final bool? enableNext,
  }) {
    return ApiState(
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      params: params ?? this.params,
      authorization: authorization ?? this.authorization,
      body: body ?? this.body,
      enableNext: enableNext ?? this.enableNext,
    );
  }
}
