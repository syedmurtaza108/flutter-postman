import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class DartCodeViewerThemeData with Diagnosticable {
  const DartCodeViewerThemeData({
    this.baseStyle,
    this.classStyle,
    this.commentStyle,
    this.constantStyle,
    this.keywordStyle,
    this.numberStyle,
    this.punctuationStyle,
    this.stringStyle,
    this.backgroundColor,
    this.copyButtonText,
    this.showCopyButton,
    this.height,
    this.width,
    this.buttonStyle,
  });

  final TextStyle? baseStyle;
  final TextStyle? classStyle;
  final TextStyle? commentStyle;
  final TextStyle? constantStyle;
  final TextStyle? keywordStyle;
  final TextStyle? numberStyle;
  final TextStyle? punctuationStyle;
  final TextStyle? stringStyle;
  final Color? backgroundColor;
  final Text? copyButtonText;
  final bool? showCopyButton;
  final double? height;
  final double? width;
  final ButtonStyle? buttonStyle;

  DartCodeViewerThemeData copyWith({
    TextStyle? baseStyle,
    TextStyle? classStyle,
    TextStyle? commentStyle,
    TextStyle? constantStyle,
    TextStyle? keywordStyle,
    TextStyle? numberStyle,
    TextStyle? punctuationStyle,
    TextStyle? stringStyle,
    Color? backgroundColor,
    Text? copyButtonText,
    bool? showCopyButton,
    double? height,
    double? width,
    ButtonStyle? buttonStyle,
  }) {
    return DartCodeViewerThemeData(
      baseStyle: baseStyle ?? this.baseStyle,
      classStyle: classStyle ?? this.classStyle,
      commentStyle: commentStyle ?? this.commentStyle,
      constantStyle: constantStyle ?? this.constantStyle,
      keywordStyle: keywordStyle ?? this.keywordStyle,
      numberStyle: numberStyle ?? this.numberStyle,
      punctuationStyle: punctuationStyle ?? this.punctuationStyle,
      stringStyle: stringStyle ?? this.stringStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      copyButtonText: copyButtonText ?? this.copyButtonText,
      showCopyButton: showCopyButton ?? this.showCopyButton,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static DartCodeViewerThemeData lerp(
    DartCodeViewerThemeData a,
    DartCodeViewerThemeData b,
    double t,
  ) {
    return DartCodeViewerThemeData(
      baseStyle: TextStyle.lerp(a.baseStyle, b.baseStyle, t),
      classStyle: TextStyle.lerp(a.classStyle, b.classStyle, t),
      commentStyle: TextStyle.lerp(a.commentStyle, b.commentStyle, t),
      constantStyle: TextStyle.lerp(a.constantStyle, b.constantStyle, t),
      keywordStyle: TextStyle.lerp(a.keywordStyle, b.keywordStyle, t),
      numberStyle: TextStyle.lerp(a.numberStyle, b.numberStyle, t),
      punctuationStyle: TextStyle.lerp(
        a.punctuationStyle,
        b.punctuationStyle,
        t,
      ),
      stringStyle: TextStyle.lerp(a.stringStyle, b.stringStyle, t),
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      height: lerpDouble(a.height, b.height, t),
      width: lerpDouble(a.width, b.width, t),
    );
  }

  @override
  int get hashCode {
    return hashValues(
      baseStyle,
      classStyle,
      commentStyle,
      constantStyle,
      keywordStyle,
      numberStyle,
      punctuationStyle,
      stringStyle,
      backgroundColor,
      copyButtonText,
      showCopyButton,
      height,
      width,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) {
      return false;
    }
    return other is DartCodeViewerThemeData &&
        baseStyle == other.baseStyle &&
        classStyle == other.classStyle &&
        commentStyle == other.commentStyle &&
        constantStyle == other.constantStyle &&
        keywordStyle == other.keywordStyle &&
        numberStyle == other.numberStyle &&
        punctuationStyle == other.punctuationStyle &&
        stringStyle == other.stringStyle &&
        backgroundColor == other.backgroundColor &&
        copyButtonText == other.copyButtonText &&
        showCopyButton == other.showCopyButton &&
        height == other.height &&
        width == other.width;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(
      DiagnosticsProperty<TextStyle>(
        'baseStyle',
        baseStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<TextStyle>(
        'classStyle',
        classStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<TextStyle>(
        'commentStyle',
        commentStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<TextStyle>(
        'constantStyle',
        constantStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<TextStyle>(
        'keywordStyle',
        keywordStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<TextStyle>(
        'numberStyle',
        numberStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<TextStyle>(
        'punctuationStyle',
        punctuationStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<TextStyle>(
        'stringStyle',
        stringStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<TextStyle>(
        'stringStyle',
        stringStyle,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<Color>(
        'backgroundColor',
        backgroundColor,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<Text>(
        'copyButtonText',
        copyButtonText,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<bool>(
        'showCopyButton',
        showCopyButton,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<double>(
        'height',
        height,
        defaultValue: null,
      ),
    )
    ..add(
      DiagnosticsProperty<double>(
        'width',
        width,
        defaultValue: null,
      ),
    );
  }
}

class DartCodeViewerTheme extends InheritedTheme {
  const DartCodeViewerTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final DartCodeViewerThemeData data;

  static DartCodeViewerThemeData of(BuildContext context) {
    final dartCodeViewerTheme =
        context.dependOnInheritedWidgetOfExactType<DartCodeViewerTheme>();
    return dartCodeViewerTheme?.data ?? const DartCodeViewerThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestorTheme =
        context.findAncestorWidgetOfExactType<DartCodeViewerTheme>();
    return identical(this, ancestorTheme)
        ? child
        : DartCodeViewerTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(DartCodeViewerTheme oldWidget) =>
      data != oldWidget.data;
}
