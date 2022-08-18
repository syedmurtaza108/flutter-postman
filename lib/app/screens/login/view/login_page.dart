import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/mixins/mixins.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/screens/login/login.dart';
import 'package:flutter_postman/app/screens/signup/signup.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const route = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loading, Message {
  late final cubit = context.read<LoginCubit>();
  @override
  void initState() {
    super.initState();

    initLoadingListener(cubit.loader, context);
    initMessageListener(cubit.message, context);
    cubit.navigate.listen(
      (event) {
        context.navigator.pushNamedAndRemoveUntil(
          HomePage.route,
          (_) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors.pageBackColor,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Stack(
            children: [
              ClipPath(
                clipper: ArcClipper(),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/computers.jpg',
                      width: context.mediaQuery.size.width,
                      height: context.mediaQuery.size.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: themeColors.authCardBackColor.withOpacity(0.7),
                      ),
                      child: Lottie.asset(
                        'assets/snow.json',
                        width: context.mediaQuery.size.width,
                        height: context.mediaQuery.size.height * 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: 64.padding,
                width: context.mediaQuery.size.width,
                height: context.mediaQuery.size.height,
                child: Column(
                  children: [
                    const AppLogo(),
                    32.height,
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: themeColors.componentBackColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints:
                                    const BoxConstraints(maxWidth: 450),
                                child: Padding(
                                  padding: 32.padding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AutoSizeText(
                                        'Welcome Back!',
                                        style: context.theme.textTheme.bodyText1
                                            ?.copyWith(
                                          fontSize: 18,
                                          color:
                                              themeColors.textButtonFrontColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      16.height,
                                      AutoSizeText(
                                        'Login to continue',
                                        style: context.theme.textTheme.bodyText1
                                            ?.copyWith(
                                          color: themeColors
                                              .loginNavigationHintColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      32.height,
                                      AppTextField(
                                        title: 'Email',
                                        hint: 'Enter Email Address',
                                        onChanged: cubit.onEmailChanged,
                                        content: state.email.content,
                                        error: state.email.error,
                                      ),
                                      16.height,
                                      PasswordTextField(
                                        onChanged: cubit.onPasswordChanged,
                                        content: state.password.content,
                                        error: state.password.error,
                                      ),
                                      32.height,
                                      PrimaryButton(
                                        text: 'Login',
                                        onPressed: state.enableNext
                                            ? cubit.login
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              24.height,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AutoSizeText(
                                    "Don't have an account?",
                                    style: context.theme.textTheme.bodyText1
                                        ?.copyWith(
                                      color: themeColors.headingTextColor,
                                    ),
                                  ),
                                  2.width,
                                  AppTextButton(
                                    text: 'Sign Up',
                                    onPressed: _navigateToSignup,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void _navigateToSignup() {
    context.navigator.pushNamedAndRemoveUntil(
      SignupPage.route,
      (route) => false,
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height - 100)
      ..quadraticBezierTo(
        size.width / 4,
        size.height,
        size.width / 2,
        size.height,
      )
      ..quadraticBezierTo(
        size.width * 3 / 4,
        size.height,
        size.width,
        size.height - 100,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
