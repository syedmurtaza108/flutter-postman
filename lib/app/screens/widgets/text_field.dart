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
    return TextField(
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: AppColors.black400,
          ),
      obscureText: _showPassword,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: InkWell(
          onTap: () {
            setState(() => _showPassword = !_showPassword);
          },
          child: Icon(
            _showPassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.blueGrey[50],
        contentPadding: const EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueGrey[50] ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueGrey[50] ?? Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
