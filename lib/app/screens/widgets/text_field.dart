import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    this.title = '',
    required this.hint,
    required this.onChanged,
    required this.content,
    required this.error,
    this.borderRadius,
    this.maxLines,
    this.focusNode,
    this.readonly = false,
    super.key,
  });

  final String title;
  final String hint;
  final void Function(String)? onChanged;
  final String content;
  final String? error;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool readonly;

  @override
  State<AppTextField> createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          AutoSizeText(
            widget.title,
            style: context.theme.textTheme.bodyText1,
          ),
        if (widget.title.isNotEmpty) 16.height,
        TextFormField(
          readOnly: widget.readonly,
          focusNode: widget.focusNode,
          initialValue: widget.content,
          style: context.theme.textTheme.bodyText1,
          cursorColor: themeColors.cursorColor,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: themeColors.textFieldBackColor,
            errorText: widget.error,
            hintStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: const Color(0xff626571),
            ),
            errorStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: themeColors.errorColor,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColors.textFieldBorderColor),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColors.textFieldBorderColor),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColors.errorColor),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeColors.errorColor),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
