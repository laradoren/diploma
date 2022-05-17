import 'dart:convert';
import 'dart:ui';

import 'package:diplom/blocs/course/course_bloc.dart';
import 'package:diplom/blocs/course/course_event.dart';
import 'package:diplom/blocs/course/course_state.dart';
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

  const TeacherCourseWidget(
      {Key? key,
      required this.course,
      required this.courseBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    courseBloc.add(GetCourse(course: course));
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        primary: Colors.white,
        shadowColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 0),
      ),
      onPressed: () {  },
      child: Column(
        children: [
          BlocBuilder<CourseBloc, CourseState>(
              builder: (context, courseState) {
                if (courseState is CourseLoaded) {
                  return CourseWidget(course: courseState.course);
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
      ),
    );
  }
}


