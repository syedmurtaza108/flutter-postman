import 'package:cloud_firestore/cloud_firestore.dart';

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
    return ApiListItem(
      name: (data?['name'] ?? '').toString(),
      method: (data?['name'] ?? '').toString(),
      url: (data?['url'] ?? '').toString(),
      params: {},
      headers: {},
      body: data?['body'],
      dartCode: (data?['code'] ?? '').toString(),
      response: (data?['response'] ?? '').toString(),
      time: DateTime.fromMillisecondsSinceEpoch(data?['createdAt'] as int? ?? 0)
          .toIso8601String(),
    );
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
