import 'dart:collection';
import 'dart:ui';
import 'package:diplom/blocs/allUsersTests/all_users_tests_bloc.dart';
import 'package:diplom/blocs/course/course_bloc.dart';
import 'package:diplom/blocs/courseTests/course_tests_bloc.dart';
import 'package:diplom/blocs/usersLogsByCourse/users_logs_by_course_bloc.dart';
import 'package:diplom/models/course.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/models/user.dart';
import 'package:diplom/models/users_logs_by_course.dart';
import 'package:diplom/widgects/teacher_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCourses extends StatelessWidget {
  final List<Course> courses;
  final List<UserLog> usersLogs;
  final List<Test> tests;
  final List<UserInfo> users;

  const AllCourses({Key? key,
    required this.courses,
    required this.usersLogs,
    required this.tests,
    required this.users})
      : super(key: key);

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
                child: Text("All courses",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(93, 92, 99, 1)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: <Widget>[
                  if (courses.isEmpty) ...[
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
                        child: Text("You don't have courses yet",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(93, 92, 99, 1))),
                      ),
                    )
                  ] else ...[
                    for (var course in courses)
                      BlocProvider<CourseBloc>(
                        create: (_) => CourseBloc(),
                        child: Builder(
                        builder: (context) {
                          final courseBloc =
                          BlocProvider.of<CourseBloc>(context);
                          return TeacherCourseWidget(
                              course: course.course.course,
                              courseBloc: courseBloc,
                              usersLogs: usersLogs,
                              tests: tests,
                              users: users

                          );
                          }
                        ),
                      ),
                  ]
                ],
              ),
            )
          ],
        ));
  }
}