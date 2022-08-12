import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';

mixin Loading {
  void initLoadingListener(
    Stream<bool> loaderStream,
    BuildContext context,
  ) {
    loaderStream.listen((event) {
      if (event) {
        LoadingDialog.show(context);
        return;
      }
      LoadingDialog.hide(context);
    });
  }
}
