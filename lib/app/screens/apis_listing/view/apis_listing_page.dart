import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/apis_listing/apis_listing.dart';
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
        return ListView.separated(
          itemBuilder: (_, i) => Accordion(
            maxOpenSections: 2,
            headerBackgroundColorOpened: Colors.black54,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            children: [
              AccordionSection(
                isOpen: true,
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: Colors.black,
                headerBackgroundColorOpened: Colors.red,
                header: Text('Introduction'),
                content: Text('_loremIpsum'),
                contentHorizontalPadding: 20,
                contentBorderWidth: 1,
                // onOpenSection: () => print('onOpenSection ...'),
                // onCloseSection: () => print('onCloseSection ...'),
              ),
              AccordionSection(
                isOpen: true,
                leftIcon:
                    const Icon(Icons.compare_rounded, color: Colors.white),
                header: Text('Nested Accordion'),
                contentBorderColor: const Color(0xffffffff),
                headerBackgroundColorOpened: Colors.amber,
                content: Accordion(
                  maxOpenSections: 1,
                  headerBackgroundColorOpened: Colors.black54,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  children: [
                    AccordionSection(
                      isOpen: true,
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: Text('Nested Section #1'),
                      content: Text('_loremIpsum'),
                      contentHorizontalPadding: 20,
                      contentBorderColor: Colors.black54,
                    ),
                    AccordionSection(
                      isOpen: true,
                      leftIcon: const Icon(Icons.compare_rounded,
                          color: Colors.white),
                      header: Text('Nested Section #2'),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      contentBorderColor: Colors.black54,
                      content: Row(
                        children: [
                          const Icon(Icons.compare_rounded,
                              size: 120, color: Colors.orangeAccent),
                          Flexible(
                              flex: 1,
                              child: Text('_loremIpsum')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.food_bank, color: Colors.white),
                header: Text('Company Info'),
                content: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 1,
                  dataRowHeight: 40,
                  showBottomBorder: false,
                  columns: [
                    DataColumn(
                        label: Text('ID'),
                        numeric: true),
                    DataColumn(
                        label: Text('Description')),
                    DataColumn(
                        label: Text('Price'),
                        numeric: true),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('1', textAlign: TextAlign.right)),
                        DataCell(Text('Fancy Product')),
                        DataCell(Text(r'$ 199.99', textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('2', textAlign: TextAlign.right)),
                        DataCell(Text('Another Product')),
                        DataCell(Text(r'$ 79.00', textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('3', textAlign: TextAlign.right)),
                        DataCell(
                            Text('Really Cool Stuff')),
                        DataCell(Text(r'$ 9.99', textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('4', textAlign: TextAlign.right)),
                        DataCell(Text('Last Product goes here')),
                        DataCell(Text(r'$ 19.99', textAlign: TextAlign.right))
                      ],
                    ),
                  ],
                ),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.contact_page, color: Colors.white),
                header: Text('Contact'),
                content: Wrap(
                  children: List.generate(
                      30,
                      (index) => const Icon(Icons.contact_page,
                          size: 30, color: Color(0xff999999))),
                ),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.computer, color: Colors.white),
                header: Text('Jobs'),
                content: const Icon(Icons.computer,
                    size: 200, color: Color(0xff999999)),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.movie, color: Colors.white),
                header: Text('Culture'),
                content: const Icon(Icons.movie,
                    size: 200, color: Color(0xff999999)),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.people, color: Colors.white),
                header: Text('Community'),
                content: const Icon(Icons.people,
                    size: 200, color: Color(0xff999999)),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.map, color: Colors.white),
                header: Text('Map'),
                content:
                    const Icon(Icons.map, size: 200, color: Color(0xff999999)),
              ),
            ],
          ),
          separatorBuilder: (_, __) => const Divider(),
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
