import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/home/home.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:sidebarx/sidebarx.dart';

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
  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a1d21),
      body: Row(
        children: [
          SidebarX(
            controller: _controller,
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff212529),
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: context.theme.textTheme.bodyText1,
              selectedTextStyle: context.theme.textTheme.bodyText1,
              itemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey,
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 20,
              ),
            ),
            extendedTheme: const SidebarXTheme(
              width: 200,
              decoration: BoxDecoration(color: Color(0xff212529)),
              margin: EdgeInsets.only(right: 10),
            ),
            headerBuilder: (context, extended) {
              return SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset('assets/text_logo.png'),
                ),
              );
            },
            items: [
              SidebarXItem(
                icon: Icons.home,
                label: 'Home',
                onTap: () {
                  debugPrint('Hello');
                },
              ),
              const SidebarXItem(
                icon: Icons.api,
                label: 'Search',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text('he'),
            ),
          ),
        ],
      ),

      // body: BlocBuilder<HomeCubit, HomeState>(
      //   builder: (context, state) {
      //     return Column(
      //       children: [
      //         const _TopWidget(),
      //         Expanded(
      //           child: Row(
      //             children: [
      //               16.width,
      //               NavigationRail(
      //                 onDestinationSelected: cubit.selectScreen,
      //                 backgroundColor: AppColors.black300,
      //                 destinations: [
      //                   NavigationRailDestination(
      //                     icon: Image.asset(
      //                       'assets/code.png',
      //                       color: const Color(0xff3b3b3f),
      //                       width: 26,
      //                       height: 26,
      //                     ),
      //                     selectedIcon: Image.asset(
      //                       'assets/code_selected.png',
      //                       width: 26,
      //                       height: 26,
      //                     ),
      //                     label: 'Home'.body1,
      //                   ),
      //                   NavigationRailDestination(
      //                     icon: Image.asset(
      //                       'assets/collection.png',
      //                       color: const Color(0xff3b3b3f),
      //                       width: 26,
      //                       height: 26,
      //                     ),
      //                     selectedIcon: Image.asset(
      //                       'assets/collection_selected.png',
      //                       width: 26,
      //                       height: 26,
      //                     ),
      //                     label: 'Collection'.body1,
      //                   ),
      //                 ],
      //                 selectedIndex: state.selectedScreenIndex,
      //               ),
      //               Expanded(
      //                 child: Container(
      //                   color: AppColors.black400,
      //                   width: double.maxFinite,
      //                   height: double.maxFinite,
      //                   margin: 16.horizontal,
      //                   padding: 16.padding,
      //                   child: 'Hello'.body1,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
