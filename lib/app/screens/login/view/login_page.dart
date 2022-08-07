import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 8,
        ),
        children: const [_Menu(), _Body()],
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 30.vertical,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: 16.horizontal,
                child: Column(
                  children: [
                    'Login'.body1.withColor(Colors.black),
                    6.height,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.black400,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                  ],
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey[50] ?? Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                      child: 'Sign Up'.body1.withColor(AppColors.black400),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Sign In to \nFlutter Postman'
                  .body1
                  .withColor(AppColors.black400)
                  .withFont(45),
              30.height,
              "If you don't have an account"
                  .body1
                  .withColor(AppColors.black400),
              10.height,
              Row(
                children: [
                  'You can'.body1.withColor(AppColors.black400),
                  4.width,
                  InkWell(
                    onTap: () {},
                    borderRadius: 8.border,
                    child: Padding(
                      padding: 8.padding,
                      child: 'Register here!'
                          .body1
                          .withColor(AppColors.black400)
                          .bold,
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/login_illustration_2.png',
                width: 300,
              ),
            ],
          ),
        ),
        Image.asset(
          'assets/login_illustration.png',
          width: 300,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 6,
          ),
          child: SizedBox(
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColors.black400,
                      ),
                  decoration: InputDecoration(
                    hintText: 'Enter email or Phone number',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    contentPadding: const EdgeInsets.only(left: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey[50] ?? Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey[50] ?? Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                30.height,
                const PasswordTextField(),
                16.height,
                InkWell(
                  onTap: () {},
                  borderRadius: 4.border,
                  child: Padding(
                    padding: 4.padding,
                    child: 'Forgot Password?'.body1.withColor(
                          AppColors.black400,
                        ),
                  ),
                ),
                40.height,
                PrimaryButton(
                  text: 'Login',
                  onPressed: () {},
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
