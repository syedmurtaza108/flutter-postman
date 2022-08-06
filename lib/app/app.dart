import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/screens/login/login.dart';
import 'package:flutter_postman/app/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({required this.userSignedIn, super.key});

  final bool userSignedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: userSignedIn
          ? BlocProvider(
              create: (context) => HomeCubit(),
              child: const HomePage(),
            )
          : const LoginPage(),
    );
  }
}
