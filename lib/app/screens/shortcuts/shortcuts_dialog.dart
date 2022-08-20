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
        backgroundColor: themeColors.pageBackColor,
        content: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Keyboard Shortcuts',
                  style: context.theme.textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                16.height,
                const ShortcutWidget(
                  title: 'SWITCH CURRENT THEME',
                  shortcut: 'ALT + T',
                ),
                16.height,
                const ShortcutWidget(
                  title: 'LOGOUT',
                  shortcut: 'ALT + L',
                ),
                16.height,
                const ShortcutWidget(
                  title: 'OPEN SHORTCUT INFORMATION',
                  shortcut: 'ALT + C',
                ),
                32.height,
                PrimaryButton(
                  text: 'OK',
                  onPressed: context.navigator.pop,
                  autoFocus: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
