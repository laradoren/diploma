import 'dart:convert';

import 'package:diplom/models/log.dart';

List<UsersLogsByCourse> postFromJson(String str) =>
    List<UsersLogsByCourse>.from(json.decode(str).map((x) => UsersLogsByCourse.fromMap(x)));

class UsersLogsByCourse {
  final String? userId;
  final List<UserLog>? logs;

  const UsersLogsByCourse({
    required this.userId,
    required this.logs
  });

  factory UsersLogsByCourse.fromMap(Map<String, dynamic> json) => UsersLogsByCourse(
    userId: json['userId'],
    logs: json['logs'],
  );
}