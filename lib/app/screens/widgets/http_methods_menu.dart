import 'package:flutter/material.dart';
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
      color: const Color(0xff262a2f),
      position: PopupMenuPosition.under,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff2a2f34)),
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
              methodName.body1,
              8.width,
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              )
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
        tileColor: const Color(0xff262a2f),
        title: Text(text, style: context.theme.textTheme.bodyText1),
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
}
