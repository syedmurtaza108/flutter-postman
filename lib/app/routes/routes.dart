import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/screens/login/login.dart';
import 'package:flutter_postman/app/screens/signup/signup.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.route:
      return FadeTransitionRoute(
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginPage(),
        ),
        settings: settings,
      );
    case SignupPage.route:
      return FadeTransitionRoute(
        child: BlocProvider(
          create: (context) => SignupCubit(),
          child: const SignupPage(),
        ),
        settings: settings,
      );
    case HomePage.route:
      return FadeTransitionRoute(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeCubit()),
            BlocProvider(create: (context) => ApiCubit()),
          ],
          child: const HomePage(),
        ),
        settings: settings,
      );
    default:
      return null;
  }
}

class FadeTransitionRoute extends MaterialPageRoute<void> {
  FadeTransitionRoute({
    required this.child,
    required super.settings,
  }) : super(builder: (_) => child);

  final Widget child;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
