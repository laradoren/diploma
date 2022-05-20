import 'dart:convert';
import 'dart:ui';

import 'package:diplom/blocs/course/course_bloc.dart';
import 'package:diplom/blocs/course/course_event.dart';
import 'package:diplom/blocs/course/course_state.dart';
import 'package:diplom/blocs/courseTests/course_tests_bloc.dart';
import 'package:diplom/blocs/courseTests/course_tests_state.dart';
import 'package:diplom/blocs/courseTests/course_tests_event.dart';
import 'package:diplom/blocs/usersLogsByCourse/users_logs_by_course_bloc.dart';
import 'package:diplom/blocs/usersLogsByCourse/users_logs_by_course_event.dart';
import 'package:diplom/blocs/usersLogsByCourse/users_logs_by_course_state.dart';
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
  final UsersLogsByCoursesBloc usersLogsBloc;
  final CourseTestsBloc courseTestsBloc;

  const TeacherCourseWidget(
      {Key? key,
      required this.course,
      required this.courseBloc,
        required this.usersLogsBloc,
      required this.courseTestsBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    courseBloc.add(GetCourse(course: course));
    courseTestsBloc.add(GetCourseTests(course: course));
    return Column(
        children: [
          BlocBuilder<CourseBloc, CourseState>(
              builder: (context, courseState) {
                if (courseState is CourseLoaded) {
                  usersLogsBloc.add(GetUsersLogsByCoursesFromTime(users: courseState.course.users));
                  return BlocBuilder<UsersLogsByCoursesBloc, UsersLogsByCoursesState>(
                    builder: (context, usersLogsByCourseState) {
                    if (usersLogsByCourseState is UsersLogsByCoursesLoaded) {
                      return BlocBuilder<CourseTestsBloc , CourseTestsState>(
                      builder: (context, courseTestsState) {
                        if (courseTestsState is CourseTestsLoaded) {
                          return CourseWidget(course: courseState.course, usersLogs:
                          usersLogsByCourseState.usersLogs,
                          courseTests: courseTestsState.courseTests);
                        } else {
                          return Container();
                        }
                      });
                    } else {
                      return _buildLoading();
                    }
                    });
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


