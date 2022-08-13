import 'package:flutter/material.dart';
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
        'Flutter'.body1.withFont(size),
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
                color: const Color(0xffffae00),
              ),
            ),
          ),
        ),
        8.width,
        'Postman'.body1.withFont(size),
      ],
    );
  }
}
