import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog._();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: const Color(0xfff2f2f2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/loading.json', width: 100, height: 100),
            const SizedBox(height: 16),
            Text(
              'Your request is being processed',
              style: context.theme.textTheme.bodyText1!.copyWith(
                color: AppColors.black300,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static const _dialog = LoadingDialog._();

  static Future<void> show(BuildContext context) async {
    return showGeneralDialog<void>(
      context: context,
      pageBuilder: (_, __, ___) => _dialog,
      barrierDismissible: false,
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Future<void> hide(BuildContext context) async {
    return _closeDialog(context);
  }

  static void _closeDialog(BuildContext context) {
    final rootNavigator = Navigator.of(context, rootNavigator: true);

    if (_isDialogVisible(context)) {
      rootNavigator.pop();
    }
  }

  static bool _isDialogVisible(BuildContext context) {
    var isVisible = false;
    Navigator.of(context, rootNavigator: true).popUntil((route) {
      isVisible = route is PopupRoute;
      return !isVisible;
    });
    return isVisible;
  }
}
