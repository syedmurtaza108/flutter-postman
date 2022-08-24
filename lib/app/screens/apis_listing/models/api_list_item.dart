import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class ApiListItem {
  ApiListItem({
    required this.name,
    required this.method,
    required this.url,
    required this.params,
    required this.headers,
    required this.body,
    required this.response,
    required this.dartCode,
    required this.time,
  });

  factory ApiListItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    // ignore: avoid_unused_constructor_parameters
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    var body = data?['body'];
    try {
      if (body != null) {
        body = jsonEncode(body);
      }
    } catch (e) {
      log(e.toString());
    }
    return ApiListItem(
      name: (data?['name'] ?? '').toString(),
      method: (data?['type'] ?? '').toString().toUpperCase(),
      url: (data?['url'] ?? '').toString(),
      params: data?['params'] is Map
          ? (data!['params'] as Map).map(
              (key, value) => MapEntry(
                key.toString(),
                value.toString(),
              ),
            )
          : <String, String>{},
      headers: data?['headers'] is Map
          ? (data!['headers'] as Map).map(
              (key, value) => MapEntry(
                key.toString(),
                value.toString(),
              ),
            )
          : <String, String>{},
      body: body,
      dartCode: (data?['code'] ?? '').toString(),
      response: (data?['response'] ?? '').toString(),
      time: DateTime.fromMillisecondsSinceEpoch(data?['createdAt'] as int? ?? 0)
          .toString(),
    );
  }

  List<JsonFieldState> getParams() {
    final list = <JsonFieldState>[];
    params.forEach(
      (key, value) {
        list.add(
          JsonFieldState(
            id: const Uuid().v1(
              options: {
                'mSecs': DateTime.now().millisecondsSinceEpoch,
              },
            ),
            key: key,
            value: value,
          ),
        );
      },
    );

    return list;
  }

  List<JsonFieldState> getHeaders() {
    final list = <JsonFieldState>[];
    headers.forEach(
      (key, value) {
        list.add(
          JsonFieldState(
            id: const Uuid().v1(
              options: {
                'mSecs': DateTime.now().millisecondsSinceEpoch,
              },
            ),
            key: key,
            value: value,
          ),
        );
      },
    );

    return list;
  }

  final String name;
  final String method;
  final String url;
  final Map<String, String> headers;
  final Map<String, String> params;
  final dynamic body;
  final String response;
  final String dartCode;
  final String time;
}
