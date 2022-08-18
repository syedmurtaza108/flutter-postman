import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/screens/login/view/login_page.dart';
import 'package:flutter_postman/app/screens/logout/logout.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';
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
      backgroundColor: themeColors.pageBackColor,
      body: Sidebar(
        isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: [
          CollapsibleItem(
            text: 'NEW REQUEST',
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
        body: CustomScrollView(
          controller: ScrollController(),
          slivers: [
            SliverAppBar(
              snap: true,
              floating: true,
              title: Container(
                color: themeColors.dashboardTopContainerColor,
                height: 70,
                child: Row(
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    Container(
                      color: themeColors.userNameBackColor,
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
                              AutoSizeText(
                                'Syed Murtaza',
                                style: context.theme.textTheme.bodyText1,
                              ),
                              4.height,
                              AutoSizeText(
                                'User',
                                style: context.theme.textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    16.width,
                    Material(
                      color: themeColors.dashboardTopContainerColor,
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
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Container(
                    color: themeColors.componentBackColor,
                    width: double.maxFinite,
                    padding: 16.padding,
                    child: AutoSizeText(
                      'Syed Murtaza',
                      style: context.theme.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeColors.headingTextColor,
                      ),
                    ),
                  ),
                  const ApiView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
