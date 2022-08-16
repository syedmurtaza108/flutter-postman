import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/text_field.dart';

class JsonTextField extends StatefulWidget {
  const JsonTextField({super.key});

  @override
  State<JsonTextField> createState() => _JsonTextFieldState();
}

class _JsonTextFieldState extends State<JsonTextField> {
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hint: 'Request body in JSON',
      onChanged: (_) {},
      content: '',
      error: null,
    );
  }
}
