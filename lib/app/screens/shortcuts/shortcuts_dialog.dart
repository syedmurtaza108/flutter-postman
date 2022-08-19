import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/shortcuts/shortcuts.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class ShortcutsDialog extends StatefulWidget {
  const ShortcutsDialog({super.key});

  @override
  State<ShortcutsDialog> createState() => _ShortcutsDialogState();
}

class _ShortcutsDialogState extends State<ShortcutsDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: themeColors.componentBackColor,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Keyboard Shortcuts',
                style: context.theme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              16.height,
              Row(
                children: [
                  Text(
                    'SWITCH CURRENT THEME',
                    style: context.theme.textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  const KeyWidget(name: 'ALT + T'),
                ],
              ),
              32.height,
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'No',
                      backColor: themeColors.noButtonBackColor,
                      onPressed: _noPressed,
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: PrimaryButton(
                      text: 'Yes',
                      onPressed: _yesPressed,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _noPressed() {
    context.navigator.pop();
  }

  Future<void> _yesPressed() async {
    await FirebaseAuth.instance.signOut();
    context.navigator.pop(true);
  }
}
