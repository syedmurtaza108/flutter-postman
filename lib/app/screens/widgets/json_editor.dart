import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:json_editor/json_editor.dart';

class AppJsonEditor extends StatelessWidget {
  const AppJsonEditor({
    this.onChanged,
    this.height = 300,
    this.enabled = true,
    this.jsonText,
    super.key,
  });

  final void Function(dynamic)? onChanged;
  final double height;
  final String? jsonText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: JsonEditorTheme(
        themeData: JsonEditorThemeData(
          lightTheme: JsonTheme(
            defaultStyle: context.theme.textTheme.bodyText1,
            bracketStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: themeColors.buttonColor,
              fontFamily: AppFonts.sourceCode,
            ),
            boolStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: const Color(0xff66afff),
              fontFamily: AppFonts.sourceCode,
            ),
            commentStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: Colors.grey,
              fontFamily: AppFonts.sourceCode,
            ),
            numberStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: const Color(0xffb392f0),
              fontFamily: AppFonts.sourceCode,
            ),
            stringStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: const Color(0xffd7637b),
              fontFamily: AppFonts.sourceCode,
            ),
            keyStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: themeColors.buttonColor,
              fontFamily: AppFonts.sourceCode,
              fontWeight: FontWeight.bold,
            ),
            errorStyle: context.theme.textTheme.bodyText1?.copyWith(
              color: themeColors.errorColor,
              fontFamily: AppFonts.sourceCode,
            ),
          ),
        ),
        child: JsonEditor.string(
          onValueChanged: onChanged,
          jsonString: jsonText,
          enabled: enabled,
        ),
      ),
    );
  }
}
