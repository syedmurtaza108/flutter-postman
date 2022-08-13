import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/screens/login/view/login_page.dart';
import 'package:flutter_postman/app/screens/logout/logout.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final cubit = context.read<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a1d21),
      body: Sidebar(
        isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: [
          CollapsibleItem(
            text: 'NEW REQUEST BITRISE',
            icon: Icons.add,
            onPressed: () {},
            isSelected: true,
          ),
          CollapsibleItem(
            text: 'ALL REQUESTS',
            icon: Icons.list,
            onPressed: () {},
          ),
        ],
        body: Column(
          children: [
            Container(
              color: const Color(0xff292e32),
              height: 70,
              child: Row(
                children: [
                  const Expanded(child: SizedBox.shrink()),
                  Container(
                    color: const Color(0xff31373c),
                    padding: 16.padding,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: const ColoredBox(
                            color: Color(0xfffecd66),
                            child: Icon(
                              Icons.person,
                              size: 32,
                            ),
                          ),
                        ),
                        8.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Syed Murtaza'.body1,
                            4.height,
                            'User'.body2,
                          ],
                        ),
                      ],
                    ),
                  ),
                  16.width,
                  Material(
                    color: const Color(0xff292e32),
                    child: InkWell(
                      onTap: () async {
                        final logout = await context.showDialog<bool>(
                          const LogoutDialog(),
                        );

                        if (logout == true) {
                          await context.navigator.pushNamedAndRemoveUntil(
                            LoginPage.route,
                            (_) => false,
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: 8.padding,
                        child: const Icon(Icons.logout, color: Colors.white),
                      ),
                    ),
                  ),
                  24.width,
                ],
              ),
            ),
            Container(
              color: const Color(0xff212529),
              width: double.maxFinite,
              padding: 16.padding,
              child: 'NEW REQUEST'.body1.withAlign(TextAlign.start).bold,
            ),
            Container(
              color: const Color(0xff212529),
              width: double.maxFinite,
              margin: 16.padding,
              child: 'NEW REQUEST'.body1.withAlign(TextAlign.start).bold,
            ),
          ],
        ),
      ),
    );
  }
}
