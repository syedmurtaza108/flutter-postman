import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/apis_listing/apis_listing.dart';
import 'package:flutter_postman/app/screens/widgets/http_methods_menu.dart';
import 'package:flutter_postman/app/screens/widgets/json_key_value.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
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
          itemBuilder: (_, i) {
            final params = items[i].getParams();
            final headers = items[i].getHeaders();
            return Accordion(
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
                      Expanded(
                        child: Text(
                          items[i].time,
                          style: context.theme.textTheme.bodyText1,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  contentBorderColor: themeColors.textFieldBorderColor,
                  headerBackgroundColorOpened: Colors.amber,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (headers.isNotEmpty) 16.height,
                      if (headers.isNotEmpty)
                        AutoSizeText(
                          'HEADERS',
                          style: context.theme.textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: themeColors.headingTextColor,
                          ),
                        ),
                      if (headers.isNotEmpty) 16.height,
                      if (headers.isNotEmpty)
                        JsonKeyValue(
                          initialValue: headers,
                        ),
                      if (params.isNotEmpty) 16.height,
                      if (params.isNotEmpty)
                        AutoSizeText(
                          'QUERY PARAMS',
                          style: context.theme.textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: themeColors.headingTextColor,
                          ),
                        ),
                      if (params.isNotEmpty) 16.height,
                      if (params.isNotEmpty) JsonKeyValue(initialValue: params),
                      if (items[i].body != null) 16.height,
                      if (items[i].body != null)
                        AutoSizeText(
                          'REQUEST BODY',
                          style: context.theme.textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: themeColors.headingTextColor,
                          ),
                        ),
                      if (items[i].body != null) 16.height,
                      if (items[i].body != null)
                        AppJsonEditor(
                          jsonText: items[i].body?.toString(),
                          enabled: false,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
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
