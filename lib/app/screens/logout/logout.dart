import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:lottie/lottie.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: const Color(0xff212529),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/logout.json', width: 100, height: 100),
              16.height,
              Text(
                'Logout',
                style: context.theme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              16.height,
              Text(
                'Are you sure you want to log out?',
                style: context.theme.textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              32.height,
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'No',
                      backColor: const Color(0xf16f767e),
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