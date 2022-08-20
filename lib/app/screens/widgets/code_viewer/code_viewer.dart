import 'package:flutter/material.dart';

import 'package:flutter_postman/app/screens/widgets/code_viewer/highlighter.dart';
import 'package:flutter_postman/app/screens/widgets/code_viewer/theme.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class CodeViewer extends StatelessWidget {
  const CodeViewer({
    required this.code,
    super.key,
    this.height,
  });

  final String code;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final codeTextStyle = context.theme.textTheme.bodyText1?.copyWith(
      fontFamily: AppFonts.sourceCode,
    );

    final lightModeOn = context.theme.brightness == Brightness.light;

    final _defaultBaseStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.blueGrey.shade800 : Colors.blueGrey.shade50,
    );
    final _defaultClassStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.purple.shade500 : Colors.purple.shade200,
    );
    final _defaultCommentStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.pink.shade600 : Colors.pink.shade300,
    );
    final _defaultConstantStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.indigo.shade500 : Colors.yellow.shade700,
    );
    final _defaultKeywordStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.indigo.shade500 : Colors.cyan.shade300,
    );
    final _defaultNumberStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.red.shade700 : Colors.yellow.shade700,
    );
    final _defaultPunctuationalStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.blueGrey.shade800 : Colors.blueGrey.shade50,
    );
    final _defaultStringStyle = codeTextStyle?.copyWith(
      color: lightModeOn ? Colors.green.shade700 : Colors.lightGreen.shade400,
    );

    const _defaultCopyButtonText = Text('COPY ALL');
    const _defaultShowCopyButton = true;

    var dartCodeViewerThemeData = DartCodeViewerTheme.of(context);
    dartCodeViewerThemeData = dartCodeViewerThemeData.copyWith(
      baseStyle: _defaultBaseStyle,
      classStyle: _defaultClassStyle,
      commentStyle: _defaultCommentStyle,
      constantStyle: _defaultConstantStyle,
      keywordStyle: _defaultKeywordStyle,
      numberStyle: _defaultNumberStyle,
      punctuationStyle: _defaultPunctuationalStyle,
      stringStyle: _defaultStringStyle,
      backgroundColor: themeColors.codeViewerBackColor,
      copyButtonText: _defaultCopyButtonText,
      showCopyButton: _defaultShowCopyButton,
      height: height ?? MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    return DartCodeViewerTheme(
      data: dartCodeViewerThemeData,
      child: Container(
        color: dartCodeViewerThemeData.backgroundColor,
        height: dartCodeViewerThemeData.height,
        width: dartCodeViewerThemeData.width,
        child: _DartCodeViewerPage(
          codifyString(code, dartCodeViewerThemeData),
        ),
      ),
    );
  }

  TextSpan codifyString(
    String content,
    DartCodeViewerThemeData dartCodeViewerThemeData,
  ) {
    final textSpans = <TextSpan>[];
    final codeSpans = DartSyntaxPreHighlighter().format(content);
    for (final span in codeSpans) {
      textSpans.add(stringToTextSpan(span.toString(), dartCodeViewerThemeData));
    }
    return TextSpan(children: textSpans);
  }

  TextSpan stringToTextSpan(
    String string,
    DartCodeViewerThemeData dartCodeViewerThemeData,
  ) {
    return TextSpan(
      style: () {
        final styleString =
            RegExp(r'codeStyle.\w*').firstMatch(string)?.group(0);
        final dartCodeViewerTheme = dartCodeViewerThemeData;

        switch (styleString) {
          case 'codeStyle.baseStyle':
            return dartCodeViewerTheme.baseStyle;
          case 'codeStyle.numberStyle':
            return dartCodeViewerTheme.numberStyle;
          case 'codeStyle.commentStyle':
            return dartCodeViewerTheme.commentStyle;
          case 'codeStyle.keywordStyle':
            return dartCodeViewerTheme.keywordStyle;
          case 'codeStyle.stringStyle':
            return dartCodeViewerTheme.stringStyle;
          case 'codeStyle.punctuationStyle':
            return dartCodeViewerTheme.punctuationStyle;
          case 'codeStyle.classStyle':
            return dartCodeViewerTheme.classStyle;
          case 'codeStyle.constantStyle':
            return dartCodeViewerTheme.constantStyle;
          default:
            return dartCodeViewerTheme.baseStyle;
        }
      }(),
      text: () {
        final textString = RegExp("'.*'").firstMatch(string)?.group(0);
        final subString = textString!.substring(1, textString.length - 1);
        return decodeString(subString);
      }(),
    );
  }

  String decodeString(String string) {
    return string
        .replaceAll(r'\u000a', '\n')
        .replaceAll(r'\u0027', "'")
        .replaceAll(r'\u0009', '\t');
  }
}

class _DartCodeViewerPage extends StatelessWidget {
  const _DartCodeViewerPage(this.code);
  final TextSpan code;

  @override
  Widget build(BuildContext context) {
    final _richTextCode = code;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 4, left: 16),
          child: SelectableText.rich(
            _richTextCode,
            textDirection: TextDirection.ltr,
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Material(
            color: themeColors.codeViewerBackColor,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: 8.padding,
                child: Icon(
                  Icons.copy,
                  color: themeColors.logoutIconColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
