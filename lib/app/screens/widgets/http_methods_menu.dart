import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

class HttpMethodsMenu extends StatefulWidget {
  const HttpMethodsMenu({
    required this.httpMethod,
    required this.onFilter,
    super.key,
  });

  final HttpMethod httpMethod;

  final void Function(HttpMethod) onFilter;

  @override
  State<HttpMethodsMenu> createState() => _HttpMethodsMenuState();
}

class _HttpMethodsMenuState extends State<HttpMethodsMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: themeColors.textFieldBackColor,
      position: PopupMenuPosition.under,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: methodColor,
          border: Border.all(color: themeColors.textFieldBorderColor),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
        ),
        padding: 16.horizontal,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                methodName,
                style: context.theme.textTheme.bodyText1?.copyWith(
                  color: Colors.white,
                ),
              ),
              8.width,
              const Icon(Icons.arrow_drop_down, color: Colors.white)
            ],
          ),
        ),
      ),
      itemBuilder: (_) => [
        _radioButton('GET', HttpMethod.get),
        _radioButton('POST', HttpMethod.post),
        _radioButton('PUT', HttpMethod.put),
        _radioButton('PATCH', HttpMethod.patch),
        _radioButton('DELETE', HttpMethod.delete),
      ],
    );
  }

  PopupMenuEntry<void> _radioButton(
    String text,
    HttpMethod httpMethod,
  ) {
    return PopupMenuItem(
      padding: 0.padding,
      onTap: () {
        widget.onFilter(httpMethod);
      },
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        contentPadding: const EdgeInsets.all(8),
        dense: true,
        tileColor: themeColors.textFieldBackColor,
        title: Text(
          text,
          style: context.theme.textTheme.bodyText1,
        ),
      ),
    );
  }

  String get methodName {
    switch (widget.httpMethod) {
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      case HttpMethod.patch:
        return 'PATCH';
      case HttpMethod.delete:
        return 'DELETE';
    }
  }

  Color get methodColor {
    final lMethod = methodName.toLowerCase();
    if (lMethod.contains('get')) {
      return Colors.brown[600]!;
    } else if (lMethod.contains('put')) {
      return Colors.blue[900]!;
    } else if (lMethod.contains('post')) {
      return Colors.teal[700]!;
    } else if (lMethod.contains('patch')) {
      return Colors.black;
    } else if (lMethod.contains('delete')) {
      return Colors.red;
    }
    return Colors.orangeAccent;
  }
}
