import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/app.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:flutter_postman/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuth = FirebaseAuth.instance;
  const themeMode = ThemeMode.light;
  setThemeColors(themeMode == ThemeMode.light ? LightTheme() : DarkTheme());

  runApp(
    MyApp(
      userSignedIn: firebaseAuth.authStateChanges().first.isNotNull,
    ),
  );
}
