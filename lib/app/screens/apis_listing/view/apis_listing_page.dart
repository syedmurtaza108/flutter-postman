import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/apis_listing/apis_listing.dart';
import 'package:flutter_postman/app/screens/widgets/http_methods_menu.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class ApisListing extends StatefulWidget {
  const ApisListing({super.key});

  @override
  State<ApisListing> createState() => _ApisListingState();
}

class _ApisListingState extends State<ApisListing> {
  late final cubit = context.read<ApisListingCubit>();
  @override
  void initState() {
    super.initState();
    cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApisListingCubit, ApisListingState>(
      builder: (context, state) {
        if (state is ApisListingLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ApisListingError) {
          return const Center(child: Text("DAta error"));
        }
        final items = (state as ApisListingData).items;
        return ListView.builder(
          padding: 16.padding,
          itemBuilder: (_, i) => Accordion(
            paddingListBottom: 0,
            paddingListTop: 0,
            paddingListHorizontal: 0,
            contentVerticalPadding: 0,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            children: [
              AccordionSection(
                headerBackgroundColor: themeColors.sideBarSelectedColor,
                contentBackgroundColor: themeColors.componentBackColor,
                leftIcon: Chip(
                  backgroundColor: methodColor(items[i].method),
                  label: Text(
                    items[i].method,
                    style: context.theme.textTheme.bodyText1?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                header: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${items[i].name} ',
                          style: context.theme.textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: items[i].url,
                              style: context.theme.textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    8.width,
                    Text(
                      items[i].time,
                      style: context.theme.textTheme.bodyText1,
                    ),
                  ],
                ),
                contentBorderColor: themeColors.textFieldBorderColor,
                headerBackgroundColorOpened: Colors.amber,
                content: DataTable(
                  sortColumnIndex: 1,
                  dataRowHeight: 40,
                  columns: const [
                    DataColumn(label: Text('ID'), numeric: true),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Price'), numeric: true),
                  ],
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(Text('1', textAlign: TextAlign.right)),
                        DataCell(Text('Fancy Product')),
                        DataCell(Text(r'$ 199.99', textAlign: TextAlign.right))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          itemCount: items.length,
        );
        // return DataTable2(
        //   columnSpacing: 12,
        //   horizontalMargin: 12,
        //   minWidth: 600,
        //   columns: [
        //     DataColumn2(
        //       label: Text(
        //         'TIME',
        //         style: context.theme.textTheme.headline1,
        //       ),
        //     ),
        //     DataColumn(
        //       label: Text(
        //         'URL',
        //         style: context.theme.textTheme.headline1,
        //       ),
        //     ),
        //   ],
        //   rows: List<DataRow>.generate(
        //     items.length,
        //     (index) => DataRow(
        //       cells: [
        //         DataCell(
        //           SelectableText(
        //             items[index].time,
        //             style: context.theme.textTheme.bodyText1,
        //           ),
        //         ),
        //         DataCell(
        //           SelectableText(
        //             items[index].url,
        //             style: context.theme.textTheme.bodyText1,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}
