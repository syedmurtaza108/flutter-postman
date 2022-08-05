import 'package:flutter/material.dart';
import 'package:flutter_postman/app/utils/utils.dart';

part './search_field.dart';
part './top_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black300,
      body: Column(
        children: [
          const _TopWidget(),
          Expanded(
            child: Row(
              children: [
                16.width,
                NavigationRail(
                  backgroundColor: AppColors.black300,
                  destinations: [
                    NavigationRailDestination(
                      icon: const Icon(Icons.data_array),
                      label: 'Home'.body1,
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.data_array),
                      label: 'Home'.body1,
                    ),
                  ],
                  selectedIndex: 0,
                ),
                Expanded(
                  child: Container(
                    color: AppColors.black400,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    margin: 16.padding,
                    padding: 16.padding,
                    child: 'Hello'.body1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
