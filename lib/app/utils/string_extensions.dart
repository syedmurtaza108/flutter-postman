import 'package:flutter/material.dart';

extension StringX on String {
  Text get body1 => Text(
        this,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      );

  Text get body2 => Text(
        this,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      );
}
