import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/text_field.dart';

class JsonTextField extends StatefulWidget {
  const JsonTextField({required this.onChanged, super.key});

  final void Function(dynamic) onChanged;

  @override
  State<JsonTextField> createState() => _JsonTextFieldState();
}

class _JsonTextFieldState extends State<JsonTextField> {
  final jsonEncoder = const JsonEncoder.withIndent('  ');
  Timer? debounce;
  var _prettyJson = '';

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hint: 'Request body in JSON',
      onChanged: (text) {
        try {
          final json = jsonDecode(text);
          _prettyJson = jsonEncoder.convert(json);
          widget.onChanged(json);
        } catch (e) {
          log(e.toString());
        }
        if (debounce?.isActive ?? false) debounce?.cancel();

        debounce = Timer(
          const Duration(milliseconds: 500),
          () => setState(() {}),
        );
      },
      content: _prettyJson,
      error: null,
      maxLines: 10,
    );
  }
}
