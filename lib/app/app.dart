import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/routes/routes.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/screens/login/login.dart';
import 'package:flutter_postman/app/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    required this.userSignedIn,
    super.key,
  });

  final bool userSignedIn;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: _MyAppView(userSignedIn: userSignedIn),
    );
  }
}

class _MyAppView extends StatelessWidget {
  const _MyAppView({
    required this.userSignedIn,
  });

  final bool userSignedIn;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Postman',
          theme: state == ThemeMode.light ? LightTheme.theme : DarkTheme.theme,
          initialRoute: userSignedIn ? HomePage.route : LoginPage.route,
          onGenerateRoute: onGenerateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void switchToLight() {
    setThemeColors(LightTheme());
    emit(ThemeMode.light);
  }

  void switchToDark() {
    setThemeColors(DarkTheme());
    emit(ThemeMode.dark);
  }
}
