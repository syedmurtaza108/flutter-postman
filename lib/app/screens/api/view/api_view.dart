import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class ApiView extends StatefulWidget {
  const ApiView({
    required this.title,
    super.key,
  });

  final String title;

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  @override
  Widget build(BuildContext context) {
    const color = Color(0xffced4da);
    return Column(
      children: [
        Container(
          color: const Color(0xff212529),
          width: double.maxFinite,
          margin: 16.padding,
          padding: 16.padding,
          child: Row(
            children: [
              Expanded(
                child: widget.title.body1
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
                  onTap: () {},
                  child: Padding(
                    padding: 8.padding,
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
                  onTap: () {},
                  child: Padding(
                    padding: 8.padding,
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
                children: [
                  HttpMethodsMenu(
                    httpMethod: HttpMethod.get,
                    onFilter: (_) {},
                  ),
                  Expanded(
                    child: AppTextField(
                      title: '',
                      hint: 'Enter request URL',
                      onChanged: (_) {},
                      content: '',
                      error: null,
                    ),
                  ),
                  16.width,
                  SizedBox(
                    width: 100,
                    child: PrimaryButton(
                      text: 'SEND',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              16.height,
              'QUERY PARAMS'
                  .body1
                  .withAlign(TextAlign.start)
                  .bold
                  .withColor(const Color(0xffced4da)),
              16.height,
              const JsonTextField(),
            ],
          ),
        ),
      ],
    );
  }
}
