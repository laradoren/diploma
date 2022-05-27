import 'dart:ui';

import 'package:diplom/api/courses.dart';
import 'package:diplom/models/chart_data.dart';
import 'package:diplom/models/course.dart';
import 'package:diplom/models/data.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/models/user.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:diplom/widgects/diagram_widget.dart';
import 'package:diplom/widgects/graphic_widget.dart';
import 'package:diplom/widgects/staticticts_info_widget.dart';
import 'package:diplom/widgects/weekly_text_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class WeeklyChartsWidget extends StatefulWidget {
  final List<Course> courses;
  final List<UserLog> usersLogs;
  final List<Test> tests;
  final List<UserInfo> users;

  const WeeklyChartsWidget(
      {Key? key,
        required this.courses,
        required this.usersLogs,
        required this.tests,
        required this.users
      })
      : super(key: key);

  @override
  State<WeeklyChartsWidget> createState() => _WeeklyChartsWidgetState();
}

class _WeeklyChartsWidgetState extends State<WeeklyChartsWidget> {
  List<ChartData> _userTimeByWeek = <ChartData>[];
  List<ChartData> _userTestByWeek = <ChartData>[];
  List<UserLog> _usersLogsByWeek = <UserLog>[];
  List<Data> _mostActiveUsers = <Data>[];
  List<Data> _bestTestResult = <Data>[];

  @override
  void initState() {
    final Calculator calculator = Calculator();
    _usersLogsByWeek = calculator.getUsersLogByWeek(widget.usersLogs, widget.courses);
    _userTimeByWeek = calculator.getTimeChartData(widget.usersLogs, widget.courses);
    _mostActiveUsers = calculator.calculateMostActiveUsers(_usersLogsByWeek, widget.courses, widget.users);
    _userTestByWeek = calculator.getTestChartData(widget.tests, widget.courses);
    _bestTestResult = calculator.calculateBestTestResult(widget.tests, widget.courses, widget.users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 10,
          thickness: 10,
          color: Color.fromRGBO(218, 220, 239, 1),

        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Text("Weekly events",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        GraphicWidget(header: "Spent users time by week", data: _userTimeByWeek, height: 100),
        WeeklyTextRow(header: "Most active students for week", data: _mostActiveUsers),
        GraphicWidget(header: "Test course passed by week", data: _userTestByWeek, height: 100),
        WeeklyTextRow(header: "The best results for a week", data: _bestTestResult)
      ],
    );
  }
}
