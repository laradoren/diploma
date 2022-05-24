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
  final List<ShortCourse> courses;
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
  static final List<ChartData> _countOfActiveUsers = <ChartData>[];
  static final List<ChartData> _countOfAllSpentTime = <ChartData>[];
  static final List<ChartData> _mostPopularBranches = <ChartData>[];
  static final List<Data> _lessPopularBranches = <Data>[];
  static final List<ChartData> _usersTestsGaps = <ChartData>[];
  static int _heightOfActiveUsers = 100;
  static int _heightOfAllSpentTime = 100;
  static int _heightOfMostPopBranch = 100;

  void initPageState() async {
    List<ChartData> _countUsers = <ChartData>[];
    List<ChartData> _countAllTime = <ChartData>[];
    List<ChartData> _mostPopularBranch = <ChartData>[];
    List<ChartData> _lessPopularBranch = <ChartData>[];
    List<ChartData> _statisticsBranches;
    double _activeUsers;
    double _allTime;
    final Calculator calculator = Calculator();

    for(ShortCourse course in widget.courses) {
      final resultCourse = await fetchCoursesByName(course.course);
      _activeUsers = calculator.calculateActiveUsers(resultCourse, widget.users);
      _countUsers.add(ChartData(course.caption, _activeUsers));
      _allTime = calculator.calculateAllSpentTimeOnCourse(course.course, widget.usersLogs);
      _countAllTime.add(ChartData(course.caption, _allTime));
      _statisticsBranches = calculator.calculateStatisticsInBranches(resultCourse.branches, widget.usersLogs);
      _mostPopularBranch.add(_statisticsBranches[0]);
      _lessPopularBranch.add(_statisticsBranches[1]);
    }

    setState(() {
      for(var i = 0; i < widget.courses.length; i++) {
        _countOfActiveUsers.add(_countUsers[i]);
        _countOfAllSpentTime.add(_countAllTime[i]);
        _mostPopularBranches.add(_mostPopularBranch[i]);
        _lessPopularBranches.add(Data(key: _lessPopularBranch[i].x, value: _lessPopularBranch[i].y));
      }
      _heightOfActiveUsers = calculator.calculateHeightOfChart(_countOfActiveUsers);
      _heightOfAllSpentTime = calculator.calculateHeightOfChart(_countOfAllSpentTime);
      _heightOfMostPopBranch = calculator.calculateHeightOfChart(_mostPopularBranches);
    });
  }


  @override
  void initState() {
    initPageState();
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
        DiagramWidget(header: "Active students in courses", data: _countOfActiveUsers, height: _heightOfActiveUsers),
        DiagramWidget(header: "All spent hours on courses", data: _countOfAllSpentTime, height: _heightOfAllSpentTime),
        DiagramWidget(header: "Most popular branches for users", data: _mostPopularBranches, height: _heightOfMostPopBranch),
        StatisticsInfoRow(header: "Less popular branches for users", data: _lessPopularBranches),
        DiagramWidget(header: "Gaps of users test results for all tests", data: _usersTestsGaps, height: 100),
        StatisticsInfoRow(header: "The best user results in course branches for users", data: _lessPopularBranches),
        StatisticsInfoRow(header: "The less user results in course branches for users", data: _lessPopularBranches),
      ],
    );
  }
}
