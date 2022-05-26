import 'dart:ui';

import 'package:diplom/api/branch.dart';
import 'package:diplom/blocs/courseUsers/course_users_bloc.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/users_logs_by_course.dart';
import 'package:diplom/widgects/user_info_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/courseUsers/course_users_state.dart';
import '../models/course.dart';
import '../models/user.dart';
import '../utils/calculator.dart';
import 'weekly_text_row_widget.dart';

class UsersInfo extends StatefulWidget {
  final List<UserInfo> users;
  final List<UserLog> usersLogs;
  final Course course;

  const UsersInfo({Key? key, required this.users, required this.usersLogs, required this.course}) : super(key: key);

  @override
  State<UsersInfo> createState() => _UsersInfoState();

}
class _UsersInfoState extends State<UsersInfo> with TickerProviderStateMixin {
  List<UserInfo> _courseUsers = <UserInfo>[];

  @override
  void initState() {
    final Calculator calculator = Calculator();
    _courseUsers = calculator.getCourseUsers(widget.users, widget.course);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 10,
              thickness: 10,
              color: Color.fromRGBO(218, 220, 239, 1),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Text("Detail information about users in course",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(93, 92, 99, 1)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  for(UserInfo user in _courseUsers) ...[
                      UserInfoRow(
                        name: user.name,
                        surname: user.surname,
                        userId: user.id,
                        usersLogs: widget.usersLogs,
                        branches: widget.course.branches,
                      )
                  ]
                ]
              ),
            ),
          ],
        ));
  }
}