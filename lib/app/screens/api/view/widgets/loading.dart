import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class ApiResponseLoading extends StatelessWidget {
  const ApiResponseLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColors.componentBackColor,
      width: double.maxFinite,
      margin: 16.padding,
      padding: 16.padding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.radio_button_unchecked_outlined),
                    16.width,
                    Expanded(
                      child: AutoSizeText(
                        'The request has been sent. Waiting for response!',
                        style: context.theme.textTheme.bodyText1?.copyWith(
                          color: themeColors.headingTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                16.height,
                Row(
                  children: [
                    const Icon(Icons.radio_button_unchecked_outlined),
                    16.width,
                    Expanded(
                      child: AutoSizeText(
                        '''The response has been received. Waiting for code generation!''',
                        style: context.theme.textTheme.bodyText1?.copyWith(
                          color: themeColors.headingTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                16.height,
                Row(
                  children: [
                    const Icon(Icons.radio_button_unchecked_outlined),
                    16.width,
                    Expanded(
                      child: AutoSizeText(
                        'The request has been sent. Waiting for response!',
                        style: context.theme.textTheme.bodyText1?.copyWith(
                          color: themeColors.headingTextColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
