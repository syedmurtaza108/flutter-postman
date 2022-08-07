import 'package:flutter/material.dart';

extension ObjectX on Object? {
  bool get isNotNull => this != null;
}

extension TextX on Text {
  Text withColor(Color color) => Text(
        data ?? '',
        style: style?.copyWith(color: color),
      );
  Text withFont(double size) => Text(
        data ?? '',
        style: style?.copyWith(fontSize: size),
      );
  Text get bold => Text(
        data ?? '',
        style: style?.copyWith(fontWeight: FontWeight.bold),
      );
}
