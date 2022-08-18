import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/text_field.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:uuid/uuid.dart';

class JsonKeyValue extends StatefulWidget {
  const JsonKeyValue({super.key});

  @override
  State<JsonKeyValue> createState() => JsonKeyValueState();
}

class JsonKeyValueState extends State<JsonKeyValue> {
  final fields = <_JsonFieldState>[_JsonFieldState(id: '1')];

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
            key: ValueKey(e.id),
            children: [
              Padding(
                padding: 8.padding,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: e.selected,
                    activeColor: Colors.white,
                    onChanged: (_) => _selectKey(e.id),
                    checkColor: themeColors.buttonColor,
                  ),
                ),
              ),
              AppTextField(
                hint: 'Key',
                onChanged: (data) => _onKeyValueChanged(e.id, data),
                content: '',
                error: null,
              ),
              AppTextField(
                hint: 'Value',
                onChanged: (data) => _onKeyValueChanged(e.id, data),
                content: '',
                error: null,
              ),
              Visibility(
                visible: fields.length > 1,
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: themeColors.componentBackColor,
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
        _JsonFieldState(
          id: const Uuid().v1(
            options: {
              'mSecs': DateTime.now().millisecondsSinceEpoch,
            },
          ),
        ),
      );
      setState(() {});
    }
  }

  void _removeKey(String id) {
    final index = fields.indexWhere((item) => item.id == id);

    fields.removeAt(index);
    setState(() {});
  }

  void _selectKey(String id) {
    final updatedList = fields
        .map((e) => e.id == id ? e.copyWith(selected: !e.selected) : e)
        .toList();
    fields
      ..clear()
      ..addAll(updatedList);
    setState(() {});
  }
}

class _JsonFieldState {
  _JsonFieldState({
    required this.id,
    this.selected = true,
    this.key = '',
    this.value = '',
  });
  final String id;
  final bool selected;
  final String key;
  final String value;

  _JsonFieldState copyWith({
    bool? selected,
    String? key,
    String? value,
  }) {
    return _JsonFieldState(
      id: id,
      selected: selected ?? this.selected,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}
