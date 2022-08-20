import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/common_extensions.dart';

class ShortcutWidget extends StatelessWidget {
  const ShortcutWidget({
    required this.shortcut,
    required this.title,
    super.key,
  });

  final String title;
  final String shortcut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.theme.textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        const Expanded(child: SizedBox.shrink()),
        Container(
          padding: 16.padding,
          decoration: BoxDecoration(
            color: themeColors.pageBackColor,
            border: Border.all(color: themeColors.textFieldBorderColor),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            shortcut,
            style: context.theme.textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
