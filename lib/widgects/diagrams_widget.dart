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
import 'package:diplom/widgects/staticticts_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DiagramsWidget extends StatefulWidget {
  final List<Course> courses;
  final List<UserLog> usersLogs;
  final List<Test> tests;
  final List<UserInfo> users;

  const DiagramsWidget(
      {Key? key,
        required this.courses,
        required this.usersLogs,
        required this.tests,
        required this.users
      })
      : super(key: key);

  @override
  State<DiagramsWidget> createState() => _DiagramsWidgetState();
}

class _DiagramsWidgetState extends State<DiagramsWidget> {
  static final List<Data> _countOfActiveUsers = <Data>[];
  static final List<ChartData> _countOfAllSpentTime = <ChartData>[];
  static final List<ChartData> _mostPopularBranches = <ChartData>[];
  static final List<Data> _lessPopularBranches = <Data>[];
  static final List<ChartData> _usersTestsGaps = <ChartData>[];
  static List<Data> _bestUsersTestsResults = <Data>[];
  static int _heightOfAllSpentTime = 100;
  static int _heightOfMostPopBranch = 100;
  static int _heightOfUsersTestsGaps = 100;

  @override
  void initState() {
    final Calculator calculator = Calculator();
    List<ChartData> _statisticsBranches =  <ChartData>[];
    for(Course course in widget.courses) {
      if(_countOfActiveUsers.length < widget.courses.length) {
        _countOfActiveUsers.add(Data(key: course.course.caption, value: calculator.calculateActiveUsers(course, widget.users)));
      }
      _countOfAllSpentTime.add(ChartData(course.course.caption, calculator.calculateAllSpentTimeOnCourse(course.course.course, widget.usersLogs)));
      _statisticsBranches = calculator.calculateStatisticsInBranches(course.branches, widget.usersLogs);
      _mostPopularBranches.add(_statisticsBranches[0]);
      if(_lessPopularBranches.length < widget.courses.length) {
        _lessPopularBranches.add(Data(key: _statisticsBranches[1].x, value: _statisticsBranches[1].y));
      }
    }
    _usersTestsGaps.addAll(calculator.calculateTestsGapsChartData(widget.tests));
    _heightOfUsersTestsGaps = calculator.calculateHeightOfChart(_usersTestsGaps);
    _heightOfAllSpentTime = calculator.calculateHeightOfChart(_countOfAllSpentTime);
    _heightOfMostPopBranch = calculator.calculateHeightOfChart(_mostPopularBranches);
    _bestUsersTestsResults = calculator.calculateTestsStatistics(widget.tests, widget.users);
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
            child: Text("Statistics by all courses",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        StatisticsInfoRow(header: "Active students in courses", data: _countOfActiveUsers, param: "students",),
        StatisticsInfoRow(header: "Less popular branches for users", data: _lessPopularBranches, param: "seconds"),
        StatisticsInfoRow(header: "The best user tests results", data: _bestUsersTestsResults, param: "%"),
        //DiagramWidget(header: "Active students in courses", data: _countOfActiveUsers, height: _heightOfActiveUsers),
        DiagramWidget(header: "All spent hours on courses", data: _countOfAllSpentTime, height: _heightOfAllSpentTime),
        DiagramWidget(header: "Most popular branches for users", data: _mostPopularBranches, height: _heightOfMostPopBranch),
        DiagramWidget(header: "Gaps of users test results for all tests", data: _usersTestsGaps, height: _heightOfUsersTestsGaps),
      ],
    );
  }
}
