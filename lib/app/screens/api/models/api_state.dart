import 'package:flutter_postman/app/models/models.dart';

class ApiState {
  ApiState({
    this.name = const FormField(content: 'UNTITLED REQUEST'),
    this.type = 'GET',
    this.url = const FormField(),
    this.params = const <String, String>{},
    this.authorization = const FormField(),
    this.body,
    this.enableSend = false,
    this.showNameEdit = false,
  });

  final FormField name;
  final String type;
  final FormField url;
  final Map<String, String> params;
  final FormField authorization;
  final dynamic body;
  final bool enableSend;
  final bool showNameEdit;

  bool get isFormValid {
    return name.error == null && url.error == null;
  }

  ApiState copyWith({
    final FormField? name,
    final String? type,
    final FormField? url,
    final Map<String, String>? params,
    final FormField? authorization,
    final dynamic body,
    final bool? enableSend,
    final bool? showNameEdit,
  }) {
    return ApiState(
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      params: params ?? this.params,
      authorization: authorization ?? this.authorization,
      body: body ?? this.body,
      enableSend: enableSend ?? this.enableSend,
      showNameEdit: showNameEdit ?? this.showNameEdit,
    );
  }
}
