import 'dart:ui';

import 'package:diplom/blocs/course/course_bloc.dart';
import 'package:diplom/blocs/course/course_event.dart';
import 'package:diplom/blocs/course/course_state.dart';
import 'package:diplom/blocs/courseTests/course_tests_bloc.dart';
import 'package:diplom/blocs/courseTests/course_tests_event.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_bloc.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_event.dart';
import 'package:diplom/blocs/weekLogs/week_logs_bloc.dart';
import 'package:diplom/blocs/weekLogs/week_logs_event.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:diplom/widgects/pages/course_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class TeacherCourseWidget extends StatefulWidget {
  final String course;
  final CourseBloc courseBloc;
  final List<UserLog> userLogs;

  const TeacherCourseWidget(
      {Key? key,
      required this.course,
      required this.courseBloc,
      required this.userLogs})
      : super(key: key);

  @override
  State<TeacherCourseWidget> createState() => _TeacherCourseWidgetState();
}

class _TeacherCourseWidgetState extends State<TeacherCourseWidget> {
  int _progress = 0;
  double _time = 0;

  @override
  void initState() {
    final Calculator calculator = Calculator();
    setState(() {
      _progress = calculator.countProgress(widget.userLogs, widget.course);
      _time = calculator.countTime(widget.userLogs, widget.course);
    });
    // print(widget.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userWeekLogsBloc = BlocProvider.of<WeekLogsBloc>(context);
    final userBestMarkBloc = BlocProvider.of<UserBestMarkBloc>(context);
    final courseTestsBloc = BlocProvider.of<CourseTestsBloc>(context);
    widget.courseBloc.add(GetCourse(course: widget.course));
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<CourseBloc, CourseState>(
                  builder: (context, courseState) {
                    if (courseState is CourseLoaded) {
                      final String image = 'http://semantic-portal.net/images/${courseState.course.course.image}';
                      if(courseState.course.course.image != "") {
                        return Image.network(image, height: 103, width: 103);
                      } else {
                        return Image.asset('assets/images/react_icon.png');
                      }
                    } else {
                      return Container();
                    }
                  }),
              const Padding(padding: EdgeInsets.only(right: 16)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.course.capitalize(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(93, 92, 99, 1))),
                    const Padding(padding: EdgeInsets.only(top: 4)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(140, 138, 149, 1)),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                  child: Image.asset(
                                      'assets/images/star_icon.png'),
                                ),
                              ),
                              TextSpan(text: '$_progress %'),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 60)),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(140, 138, 149, 1)),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                  child: Image.asset(
                                      'assets/images/alarm_clock_icon.png'),
                                ),
                              ),
                              TextSpan(text: "$_time h."),

                            ],
                          ),
                        ),
                        // const Padding(padding: EdgeInsets.only(right: 60)),
                        // RichText(
                        //   text: TextSpan(
                        //     style: const TextStyle(
                        //         fontSize: 16,
                        //         height: 1.5,
                        //         fontWeight: FontWeight.w400,
                        //         color: Color.fromRGBO(140, 138, 149, 1)),
                        //     children: [
                        //       WidgetSpan(
                        //         child: Padding(
                        //           padding:
                        //           const EdgeInsets.fromLTRB(0, 0, 6, 0),
                        //           child: Image.asset(
                        //               'assets/images/students.png'),
                        //         ),
                        //       ),
                        //       const TextSpan(text: "10 students"),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
