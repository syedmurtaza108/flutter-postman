import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    required this.onChanged,
    required this.content,
    required this.error,
    super.key,
  });

  final void Function(String) onChanged;
  final String content;
  final String? error;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Password'.body1,
        16.height,
        TextFormField(
          initialValue: widget.content,
          style: Theme.of(context).textTheme.bodyText1,
          cursorColor: Colors.white,
          obscureText: _hidePassword,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: 'Password',
            errorText: widget.error,
            hintStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: const Color(0xff626571),
            ),
            suffixIcon: IconButton(
              splashRadius: 16,
              onPressed: () {
                setState(() => _hidePassword = !_hidePassword);
              },
              icon: Icon(
                _hidePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: themeColors.textFieldBackColor,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff2a2f34)),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff2a2f34)),
              borderRadius: BorderRadius.circular(4),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColors.errorColor),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: themeColors.errorColor),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
