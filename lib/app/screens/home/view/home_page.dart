import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/app.dart';
import 'package:flutter_postman/app/intents/intents.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/screens/apis_listing/apis_listing.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/screens/login/view/login_page.dart';
import 'package:flutter_postman/app/screens/logout/logout.dart';
import 'package:flutter_postman/app/screens/shortcuts/shortcuts.dart';
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
  final focusNode = FocusNode();
  late final cubit = context.read<HomeCubit>();
  var _selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initFocusListener();
    });
  }

  void _initFocusListener() {
    FocusScope.of(context).addListener(() {
      if (FocusScope.of(context).focusedChild == null) {
        focusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors.pageBackColor,
      body: FocusableActionDetector(
        shortcuts: {
          LogicalKeySet(
            LogicalKeyboardKey.alt,
            LogicalKeyboardKey.keyT,
          ): ThemeSwitchIntent(),
          LogicalKeySet(
            LogicalKeyboardKey.alt,
            LogicalKeyboardKey.keyL,
          ): LogoutIntent(),
          LogicalKeySet(
            LogicalKeyboardKey.alt,
            LogicalKeyboardKey.keyC,
          ): ShortcutIntent(),
        },
        actions: {
          ThemeSwitchIntent: CallbackAction<ThemeSwitchIntent>(
            onInvoke: (_) => _switchTheme(),
          ),
          LogoutIntent: CallbackAction<LogoutIntent>(
            onInvoke: (_) => _logout(),
          ),
          ShortcutIntent: CallbackAction<ShortcutIntent>(
            onInvoke: (_) => _openShortcutsDialog(),
          ),
        },
        child: Sidebar(
          isCollapsed: context.mediaQuery.size.width <= 800,
          allowCollapse: context.mediaQuery.size.width > 800,
          focusNode: focusNode,
          items: [
            CollapsibleItem(
              text: 'NEW REQUEST',
              icon: Icons.add,
              onPressed: () {
                setState(() => _selectedItemIndex = 0);
              },
              isSelected: _selectedItemIndex == 0,
            ),
            CollapsibleItem(
              text: 'ALL REQUESTS',
              icon: Icons.list,
              onPressed: () {
                setState(() => _selectedItemIndex = 1);
              },
              isSelected: _selectedItemIndex == 1,
            ),
          ],
          body: _selectedItemIndex == 0
              ? CustomScrollView(
                  controller: ScrollController(),
                  slivers: [
                    SliverAppBar(
                      snap: true,
                      floating: true,
                      backgroundColor: themeColors.dashboardTopContainerColor,
                      title: Container(
                        color: themeColors.dashboardTopContainerColor,
                        height: 100,
                        child: Row(
                          children: [
                            Material(
                              color: themeColors.dashboardTopContainerColor,
                              child: InkWell(
                                onTap: _switchTheme,
                                borderRadius: BorderRadius.circular(24),
                                child: Padding(
                                  padding: 8.padding,
                                  child: Icon(
                                    context.theme.brightness == Brightness.light
                                        ? Icons.brightness_medium_rounded
                                        : Icons.brightness_medium_outlined,
                                    color: themeColors.logoutIconColor,
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: themeColors.dashboardTopContainerColor,
                              child: InkWell(
                                onTap: _openShortcutsDialog,
                                borderRadius: BorderRadius.circular(24),
                                child: Padding(
                                  padding: 8.padding,
                                  child: Icon(
                                    Icons.keyboard,
                                    color: themeColors.logoutIconColor,
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox.shrink()),
                            Container(
                              color: themeColors.userNameBackColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 32,
                              ),
                              alignment: Alignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        'Syed Murtaza',
                                        style:
                                            context.theme.textTheme.bodyText1,
                                      ),
                                      4.height,
                                      AutoSizeText(
                                        'User',
                                        style:
                                            context.theme.textTheme.bodyText2,
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
                                onTap: _logout,
                                borderRadius: BorderRadius.circular(24),
                                child: Padding(
                                  padding: 8.padding,
                                  child: Icon(
                                    Icons.logout,
                                    color: themeColors.logoutIconColor,
                                  ),
                                ),
                              ),
                            ),
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
                              'Dashboard',
                              style:
                                  context.theme.textTheme.bodyText1?.copyWith(
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
                )
              : const ApisListing(),
        ),
      ),
    );
  }

  void _openShortcutsDialog() {
    context.showDialog<bool>(const ShortcutsDialog());
  }

  void _switchTheme() {
    final cubit = context.read<ThemeCubit>();
    switch (cubit.state) {
      case ThemeMode.system:
        break;
      case ThemeMode.light:
        cubit.switchToDark();
        break;
      case ThemeMode.dark:
        cubit.switchToLight();
        break;
    }
  }

  Future<void> _logout() async {
    final logout = await context.showDialog<bool>(
      const LogoutDialog(),
    );

    if (logout == true) {
      await context.navigator.pushNamedAndRemoveUntil(
        LoginPage.route,
        (_) => false,
      );
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
