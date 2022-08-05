import 'package:flutter/material.dart';

extension NumX on num {
  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get height => SizedBox(height: toDouble());
  EdgeInsets get padding => EdgeInsets.all(toDouble());
}
