import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 32,
    this.dotPadding = 6,
  });

  final double size;
  final double dotPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        'Flutter'.body1.withFont(size),
        Padding(
          padding: EdgeInsets.only(bottom: dotPadding),
          child: Icon(
            Icons.circle_rounded,
            size: size / 4,
            color: const Color(0xffffae00),
          ),
        ),
        8.width,
        'Postman'.body1.withFont(size),
      ],
    );
  }
}
