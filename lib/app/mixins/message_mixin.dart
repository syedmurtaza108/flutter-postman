import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

mixin Message {
  void initMessageListener(
    Stream<String> messageStream,
    BuildContext context,
  ) {
    messageStream.listen((event) {
      context.showSnackBar(event);
    });
  }
}
