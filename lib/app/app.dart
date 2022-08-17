import 'package:flutter/material.dart';
import 'package:flutter_postman/app/routes/routes.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/screens/login/login.dart';
import 'package:flutter_postman/app/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({required this.userSignedIn, super.key});

  final bool userSignedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme.theme,
      themeMode: ThemeMode.light,
      initialRoute: userSignedIn ? HomePage.route : LoginPage.route,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
