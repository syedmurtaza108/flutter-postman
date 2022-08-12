import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/mixins/mixins.dart';
import 'package:flutter_postman/app/screens/login/login.dart';
import 'package:flutter_postman/app/screens/signup/signup.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a1d21),
      body: Stack(
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
                    color: const Color(0xff3d4c81).withOpacity(0.7),
                  ),
                  child: Lottie.asset(
                    'snow.json',
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    'Flutter'.body1.withFont(32),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Icon(
                        Icons.circle_rounded,
                        size: 8,
                        color: Color(0xffffae00),
                      ),
                    ),
                    8.width,
                    'Postman'.body1.withFont(32),
                  ],
                ),
                32.height,
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff212529),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: const BoxConstraints(maxWidth: 450),
                            child: Padding(
                              padding: 32.padding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  'Welcome Back!'
                                      .body1
                                      .withFont(18)
                                      .withColor(const Color(0xff405189))
                                      .bold,
                                  16.height,
                                  'Login to continue'
                                      .body1
                                      .withColor(const Color(0xff878a99)),
                                  32.height,
                                  AppTextField(
                                    title: 'Email',
                                    hint: 'Enter Email Address',
                                    onChanged: (_) {},
                                    content: 'state.email.content',
                                    error: 'state.email.error',
                                  ),
                                  16.height,
                                  PasswordTextField(
                                    onChanged: (_) {},
                                    content: 'state.email.content',
                                    error: 'state.email.error',
                                  ),
                                  32.height,
                                  PrimaryButton(
                                    text: 'Login',
                                    onPressed: cubit.login,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          24.height,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              "Don't have an account?"
                                  .body1
                                  .withColor(const Color(0xffced4da)),
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
