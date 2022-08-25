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
        return Accordion(
          paddingListBottom: 0,
          paddingListTop: 0,
          paddingListHorizontal: 0,
          contentVerticalPadding: 0,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: items
              .map(
                (e) => AccordionSection(
                  headerBackgroundColor: themeColors.sideBarSelectedColor,
                  contentBackgroundColor: themeColors.componentBackColor,
                  leftIcon: Chip(
                    backgroundColor: methodColor(e.method),
                    label: Text(
                      e.method,
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
                            text: '${e.name} ',
                            style: context.theme.textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: e.url,
                                style: context.theme.textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      8.width,
                      Expanded(
                        child: Text(
                          e.time,
                          style: context.theme.textTheme.bodyText1,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  contentBorderColor: themeColors.textFieldBorderColor,
                  headerBackgroundColorOpened: Colors.amber,
                  content: ApiDetailsTabViews(item: e),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
