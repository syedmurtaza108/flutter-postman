import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/text_field.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:uuid/uuid.dart';

class JsonTextField extends StatefulWidget {
  const JsonTextField({super.key});

  @override
  State<JsonTextField> createState() => JsonTextFieldState();
}

class JsonTextFieldState extends State<JsonTextField> {
  final fields = <JsonFieldState>[JsonFieldState(id: '1')];

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: const Color(0xff2a2f34)),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {0: FixedColumnWidth(100), 3: FixedColumnWidth(50)},
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            Padding(
              padding: 12.vertical,
              child: 'KEY'.body1,
            ),
            'VALUE'.body1,
            const SizedBox.shrink(),
          ],
        ),
        ...fields.map(
          (e) => TableRow(
            children: [
              Padding(
                padding: 8.padding,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: e.selected,
                    activeColor: Colors.white,
                    onChanged: (_) {},
                    checkColor: const Color(0xff099885),
                  ),
                ),
              ),
              AppTextField(
                title: '',
                hint: 'Key',
                onChanged: (data) => _onKeyValueChanged(e.id, data),
                content: '',
                error: null,
              ),
              AppTextField(
                title: '',
                hint: 'Value',
                onChanged: (data) => _onKeyValueChanged(e.id, data),
                content: '',
                error: null,
              ),
              Visibility(
                visible: fields.length > 1,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xff212529),
                  child: Padding(
                    padding: 8.horizontal,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => _removeKey(e.id),
                      child: Padding(
                        padding: 8.padding,
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onKeyValueChanged(String id, String data) {
    final index = fields.indexWhere((item) => item.id == id);

    if (index == fields.length - 1) {
      fields.add(
        JsonFieldState(
          id: const Uuid().v1(
            options: {
              'mSecs': DateTime.now().millisecondsSinceEpoch,
            },
          ),
        ),
      );

      fields.forEach((element) {
        print(element.id);
      }); 
      setState(() {});
    }
  }

  void _removeKey(String id) {
    final index = fields.indexWhere((item) => item.id == id);

    fields.removeAt(index);
    print(index);
    setState(() {});
  }
}

class JsonFieldState {
  JsonFieldState({
    required this.id,
    this.selected = true,
    this.key = '',
    this.value = '',
  });
  final String id;
  final bool selected;
  final String key;
  final String value;
}
