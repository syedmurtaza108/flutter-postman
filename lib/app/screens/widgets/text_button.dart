import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class AppTextButton extends StatefulWidget {
  const AppTextButton({required this.text, required this.onPressed, super.key});

  final String text;
  final VoidCallback onPressed;

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      borderRadius: 4.border,
      child: Padding(
        padding: 8.padding,
        child: widget.text.body1.withColor(const Color(0xff405189)).bold,
      ),
    );
  }
}
