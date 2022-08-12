import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.title,
    required this.hint,
    required this.onChanged,
    required this.content,
    required this.error,
    super.key,
  });

  final String title;
  final String hint;
  final void Function(String) onChanged;
  final String content;
  final String? error;

  @override
  State<AppTextField> createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title.body1,
        16.height,
        TextFormField(
          initialValue: widget.content,
          style: Theme.of(context).textTheme.bodyText1,
          cursorColor: Colors.white,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: const Color(0xff262a2f),
            errorText: widget.error,
            errorStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: const Color(0xfff06548),
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff2a2f34)),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff2a2f34)),
              borderRadius: BorderRadius.circular(4),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xfff06548)),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xfff06548)),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
