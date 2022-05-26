import 'dart:convert';
import 'dart:ui';

import 'package:diplom/blocs/allUsersTests/all_users_tests_bloc.dart';
import 'package:diplom/blocs/allUsersTests/all_users_tests_event.dart';
import 'package:diplom/blocs/allUsersTests/all_users_tests_state.dart';
import 'package:diplom/blocs/course/course_bloc.dart';
import 'package:diplom/blocs/course/course_event.dart';
import 'package:diplom/blocs/course/course_state.dart';
import 'package:diplom/blocs/courseTests/course_tests_bloc.dart';
import 'package:diplom/blocs/courseTests/course_tests_state.dart';
import 'package:diplom/blocs/courseTests/course_tests_event.dart';
import 'package:diplom/blocs/usersLogsByCourse/users_logs_by_course_bloc.dart';
import 'package:diplom/blocs/usersLogsByCourse/users_logs_by_course_event.dart';
import 'package:diplom/blocs/usersLogsByCourse/users_logs_by_course_state.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/models/user.dart';
import 'package:diplom/widgects/course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class TeacherCourseWidget extends StatelessWidget {
  final String course;
  final CourseBloc courseBloc;
  final List<UserLog> usersLogs;
  final List<Test> tests;
  final List<UserInfo> users;

  const TeacherCourseWidget(
      {Key? key,
      required this.course,
      required this.courseBloc,
        required this.usersLogs,
        required this.tests,
      required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    courseBloc.add(GetCourse(course: course));
    return Column(
        children: [
          BlocBuilder<CourseBloc, CourseState>(
              builder: (context, courseState) {
                if (courseState is CourseLoaded) {
                  return CourseWidget(course: courseState.course, usersLogs: usersLogs, tests: tests, users: users);
                } else {
                  return Container();
                }
              }),
          const Padding(padding: EdgeInsets.only(top: 16)),
          const Divider(
            height: 2,
            thickness: 2,
            indent: 8,
            endIndent: 8,
            color: Color.fromRGBO(235, 235, 235, 1),
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
        ],
      );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}


