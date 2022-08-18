import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 32,
    this.dotPadding = 0,
    this.dotHeight,
  });

  final double size;
  final double dotPadding;
  final double? dotHeight;

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      children: [
        AutoSizeText(
          'Flutter',
          style: context.theme.textTheme.bodyText1?.copyWith(
            fontSize: size,
          ),
        ),
        SizedBox(
          width: size / 4,
          height: dotHeight ?? size / 4 * 3,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: dotPadding),
              child: Icon(
                Icons.circle_rounded,
                size: size / 4,
                color: themeColors.logoDotColor,
              ),
            ),
          ),
        ),
        8.width,
        AutoSizeText(
          'Postman',
          style: context.theme.textTheme.bodyText1?.copyWith(
            fontSize: size,
          ),
        ),
      ],
    );
  }
}
