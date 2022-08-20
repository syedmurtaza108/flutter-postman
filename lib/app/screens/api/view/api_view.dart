import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class ApiView extends StatefulWidget {
  const ApiView({
    super.key,
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  late final cubit = context.read<ApiCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiCubit, ApiState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              color: themeColors.componentBackColor,
              width: double.maxFinite,
              margin: 16.padding,
              padding: 16.padding,
              child: Row(
                crossAxisAlignment: state.showNameEdit
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: state.showNameEdit
                        ? AppTextField(
                            hint: 'Enter request name here',
                            onChanged: cubit.onNameChanged,
                            content: state.name.content,
                            error: state.name.error,
                          )
                        : AutoSizeText(
                            state.name.content,
                            style: context.theme.textTheme.bodyText1,
                          ),
                  ),
                  8.width,
                  Material(
                    color: themeColors.textIconButtonBorderColor,
                    borderRadius: BorderRadius.circular(2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(2),
                      onTap: cubit.showNameEdit,
                      child: Padding(
                        padding: 16.padding,
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: themeColors.buttonIconColor,
                              size: 16,
                            ),
                            4.width,
                            AutoSizeText(
                              'EDIT',
                              style: context.theme.textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  8.width,
                  Material(
                    color: themeColors.textIconButtonBorderColor,
                    borderRadius: BorderRadius.circular(2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(2),
                      onTap: cubit.hideNameEdit,
                      child: Padding(
                        padding: 16.padding,
                        child: Row(
                          children: [
                            Icon(
                              Icons.save,
                              color: themeColors.buttonIconColor,
                              size: 16,
                            ),
                            4.width,
                            AutoSizeText(
                              'SAVE',
                              style: context.theme.textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: themeColors.componentBackColor,
              width: double.maxFinite,
              margin: 16.horizontal,
              padding: 16.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HttpMethodsMenu(
                        httpMethod: HttpMethod.get,
                        onFilter: (_) {},
                      ),
                      Expanded(
                        child: AppTextField(
                          hint: 'Enter request URL',
                          onChanged: cubit.onUrlChanged,
                          content: state.url.content,
                          error: state.url.error,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                          focusNode: widget.focusNode,
                        ),
                      ),
                      16.width,
                      SizedBox(
                        width: 100,
                        height: 48,
                        child: PrimaryButton(
                          text: 'SEND',
                          onPressed: !state.enableSend ? null : cubit.send,
                        ),
                      ),
                    ],
                  ),
                  16.height,
                  SizedBox(
                    height: context.mediaQuery.size.height * 0.7,
                    child: const TabBarAndTabViews(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
