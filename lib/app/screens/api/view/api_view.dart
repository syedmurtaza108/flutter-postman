import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/api/api.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:json_editor/json_editor.dart';

class ApiView extends StatefulWidget {
  const ApiView({
    super.key,
  });

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  late final cubit = context.read<ApiCubit>();

  @override
  Widget build(BuildContext context) {
    const color = Color(0xffced4da);
    return BlocBuilder<ApiCubit, ApiState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              color: const Color(0xff212529),
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
                        : state.name.content.body1
                            .withAlign(TextAlign.start)
                            .bold
                            .withColor(color),
                  ),
                  8.width,
                  Material(
                    color: const Color(0xff5e6a75),
                    borderRadius: BorderRadius.circular(2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(2),
                      onTap: cubit.showNameEdit,
                      child: Padding(
                        padding: 16.padding,
                        child: Row(
                          children: [
                            const Icon(Icons.edit, color: color, size: 16),
                            4.width,
                            'EDIT'.body1,
                          ],
                        ),
                      ),
                    ),
                  ),
                  8.width,
                  Material(
                    color: const Color(0xff5e6a75),
                    borderRadius: BorderRadius.circular(2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(2),
                      onTap: cubit.hideNameEdit,
                      child: Padding(
                        padding: 16.padding,
                        child: Row(
                          children: [
                            const Icon(Icons.save, color: color, size: 16),
                            4.width,
                            'SAVE'.body1,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xff212529),
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
                        ),
                      ),
                      16.width,
                      SizedBox(
                        width: 100,
                        child: PrimaryButton(
                          text: 'SEND',
                          onPressed: !state.enableSend ? null : () {},
                        ),
                      ),
                    ],
                  ),
                  16.height,
                  'HEADERS'
                      .body1
                      .withAlign(TextAlign.start)
                      .bold
                      .withColor(const Color(0xffced4da)),
                  16.height,
                  const JsonKeyValue(),
                  16.height,
                  'QUERY PARAMS'
                      .body1
                      .withAlign(TextAlign.start)
                      .bold
                      .withColor(const Color(0xffced4da)),
                  16.height,
                  const JsonKeyValue(),
                  16.height,
                  'REQUEST BODY'
                      .body1
                      .withAlign(TextAlign.start)
                      .bold
                      .withColor(const Color(0xffced4da)),
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
                          keyStyle: context.theme.textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          errorStyle:
                              context.theme.textTheme.bodyText1?.copyWith(
                            color: const Color(0xfff06548),
                          ),
                        ),
                      ),
                      child: JsonEditor.string(),
                    ),
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
