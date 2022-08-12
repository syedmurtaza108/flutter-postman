import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({super.key});

  @override
  State<AppTextField> createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Email'.body1,
        16.height,
        TextField(
          style: Theme.of(context).textTheme.bodyText1,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Enter email address',
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
