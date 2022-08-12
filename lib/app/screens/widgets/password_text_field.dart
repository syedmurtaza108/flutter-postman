import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Password'.body1,
        16.height,
        TextField(
          style: Theme.of(context).textTheme.bodyText1,
          cursorColor: Colors.white,
          obscureText: _showPassword,
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: IconButton(
              splashRadius: 16,
              onPressed: () {
                setState(() => _showPassword = !_showPassword);
              },
              icon: Icon(
                _showPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: const Color(0xff262a2f),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff2a2f34)),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff2a2f34)),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
