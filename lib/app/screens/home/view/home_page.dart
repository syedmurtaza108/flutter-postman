import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/utils/utils.dart';

part './search_field.dart';
part './top_widget.dart';

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
      backgroundColor: AppColors.black300,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              const _TopWidget(),
              Expanded(
                child: Row(
                  children: [
                    16.width,
                    NavigationRail(
                      onDestinationSelected: cubit.selectScreen,
                      backgroundColor: AppColors.black300,
                      destinations: [
                        NavigationRailDestination(
                          icon: Image.asset(
                            'assets/code.png',
                            color: const Color(0xff3b3b3f),
                            width: 26,
                            height: 26,
                          ),
                          selectedIcon: Image.asset(
                            'assets/code_selected.png',
                            width: 26,
                            height: 26,
                          ),
                          label: 'Home'.body1,
                        ),
                        NavigationRailDestination(
                          icon: Image.asset(
                            'assets/collection.png',
                            color: const Color(0xff3b3b3f),
                            width: 26,
                            height: 26,
                          ),
                          selectedIcon: Image.asset(
                            'assets/collection_selected.png',
                            width: 26,
                            height: 26,
                          ),
                          label: 'Collection'.body1,
                        ),
                      ],
                      selectedIndex: state.selectedScreenIndex,
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.black400,
                        width: double.maxFinite,
                        height: double.maxFinite,
                        margin: 16.horizontal,
                        padding: 16.padding,
                        child: 'Hello'.body1,
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
}