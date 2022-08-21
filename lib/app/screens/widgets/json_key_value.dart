import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/text_field.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:uuid/uuid.dart';

class JsonKeyValue extends StatefulWidget {
  const JsonKeyValue({required this.onChange, super.key});

  final void Function(Map<String, String>) onChange;

  @override
  State<JsonKeyValue> createState() => JsonKeyValueState();
}

class JsonKeyValueState extends State<JsonKeyValue> {
  var fields = <_JsonFieldState>[_JsonFieldState(id: '1')];

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: themeColors.textFieldBorderColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {0: FixedColumnWidth(100), 3: FixedColumnWidth(50)},
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            Padding(
              padding: 12.vertical,
              child: AutoSizeText(
                'KEY',
                style: context.theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            AutoSizeText(
              'VALUE',
              style: context.theme.textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
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
                    activeColor: themeColors.checkBoxSelectedColor,
                    onChanged: (_) => _selectKey(e.id),
                    checkColor: themeColors.buttonColor,
                  ),
                ),
              ),
              AppTextField(
                hint: 'Key',
                onChanged: (data) => _onKeyValueChanged(e.id, data, e.value),
                content: '',
                error: null,
                borderRadius: BorderRadius.circular(0),
              ),
              AppTextField(
                hint: 'Value',
                onChanged: (data) => _onKeyValueChanged(e.id, e.key, data),
                content: '',
                error: null,
                borderRadius: BorderRadius.circular(0),
              ),
              if (fields.length > 1)
                Material(
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
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  void _onKeyValueChanged(String id, String key, String value) {
    final index = fields.indexWhere((item) => item.id == id);
    fields = fields
        .map((e) => e.id == id ? e.copyWith(key: key, value: value) : e)
        .toList();

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
    }

    final data = <String, String>{}..addEntries(
        fields
            .where(
              (e) => e.selected && e.key.isNotEmpty && e.value.isNotEmpty,
            )
            .map((e) => MapEntry(e.key, e.value)),
      );
    widget.onChange(data);
    setState(() {});
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
    fields = updatedList;
    final data = <String, String>{}..addEntries(
        fields
            .where(
              (e) => e.selected && e.key.isNotEmpty && e.value.isNotEmpty,
            )
            .map((e) => MapEntry(e.key, e.value)),
      );
    widget.onChange(data);
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
