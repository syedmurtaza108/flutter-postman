import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
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
        child: AutoSizeText(
          widget.text,
          style: context.theme.textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            color: themeColors.textButtonFrontColor,
          ),
        ),
      ),
    );
  }
}
