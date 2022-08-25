import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/apis_listing/apis_listing.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';

class ApiDetailsTabViews extends StatefulWidget {
  const ApiDetailsTabViews({required this.item, super.key});

  final ApiListItem item;

  @override
  State<ApiDetailsTabViews> createState() => _ApiDetailsTabViewsState();
}

class _ApiDetailsTabViewsState extends State<ApiDetailsTabViews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final params = widget.item.getParams();
    final headers = widget.item.getHeaders();
    return SizedBox(
      height: 200,
      child: Column(
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
              tabs: const [
                Tab(text: 'HEADERS'),
                Tab(text: 'PARAMS'),
                Tab(text: 'BODY'),
                Tab(text: 'RESPONSE'),
                Tab(text: 'CODE'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                JsonKeyValue(initialValue: headers),
                JsonKeyValue(initialValue: params),
                AppJsonEditor(
                  jsonText: widget.item.body?.toString(),
                  enabled: false,
                ),
                Text('data'),
                Text('data'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
