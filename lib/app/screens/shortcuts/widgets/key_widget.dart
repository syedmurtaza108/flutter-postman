import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class KeyWidget extends StatelessWidget {
  const KeyWidget({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.padding,
      decoration: BoxDecoration(
        border: Border.all(color: themeColors.textFieldBorderColor),
        boxShadow: const [BoxShadow(color: Colors.grey)],
      ),
      child: Text(
        name,
        style: context.theme.textTheme.bodyText1,
      ),
    );
  }
}
