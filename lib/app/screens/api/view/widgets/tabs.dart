import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:json_editor/json_editor.dart';

class TabBarAndTabViews extends StatefulWidget {
  const TabBarAndTabViews({super.key});

  @override
  State<TabBarAndTabViews> createState() => _TabBarAndTabViewsState();
}

class _TabBarAndTabViewsState extends State<TabBarAndTabViews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: themeColors.pageBackColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: themeColors.buttonColor,
            ),
            labelColor: themeColors.tabSelectedTextColor,
            unselectedLabelColor: themeColors.tabUnselectedTextColor,
            tabs: const [Tab(text: 'REQUEST'), Tab(text: 'RESPONSE')],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.height,
                    AutoSizeText(
                      'HEADERS',
                      style: context.theme.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeColors.headingTextColor,
                      ),
                    ),
                    16.height,
                    const JsonKeyValue(),
                    16.height,
                    AutoSizeText(
                      'QUERY PARAMS',
                      style: context.theme.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeColors.headingTextColor,
                      ),
                    ),
                    16.height,
                    const JsonKeyValue(),
                    16.height,
                    AutoSizeText(
                      'REQUEST BODY',
                      style: context.theme.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeColors.headingTextColor,
                      ),
                    ),
                    16.height,
                    SizedBox(
                      height: 300,
                      child: JsonEditorTheme(
                        themeData: JsonEditorThemeData(
                          lightTheme: JsonTheme(
                            defaultStyle: context.theme.textTheme.bodyText1,
                            bracketStyle: context.theme.textTheme.bodyText1,
                            boolStyle: context.theme.textTheme.bodyText1,
                            commentStyle: context.theme.textTheme.bodyText1,
                            numberStyle: context.theme.textTheme.bodyText1,
                            stringStyle: context.theme.textTheme.bodyText1,
                            keyStyle:
                                context.theme.textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            errorStyle:
                                context.theme.textTheme.bodyText1?.copyWith(
                              color: themeColors.errorColor,
                            ),
                          ),
                        ),
                        child: JsonEditor.string(
                          onValueChanged:
                              context.read<ApiCubit>().onBodyChanged,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text('Hello'),
            ],
          ),
        ),
      ],
    );
  }
}
