import 'dart:ui';

import 'package:diplom/models/chart_data.dart';
import 'package:diplom/models/course.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/models/user.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:diplom/widgects/diagram_widget.dart';
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
  static List<ChartData> _countOfActiveUsers = <ChartData>[];
  static final List<ChartData> _testChartData = <ChartData>[];

  @override
  void initState() {
    Calculator calculator = Calculator();
    _countOfActiveUsers = calculator.calculateActiveUsers(widget.courses, widget.users);
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
        DiagramWidget(header: "Active students in courses", data: _countOfActiveUsers, height: 100),
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text("Active students in courses",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SfCartesianChart(
                isTransposed: true,
                primaryXAxis: CategoryAxis(),
                primaryYAxis: CategoryAxis(
                  minimum: 0,
                  maximum: 100,
                  interval: 20,
                ),
                series: <ChartSeries>[
                  BarSeries<ChartData, String>(
                      color: const Color.fromRGBO(56, 179, 158, 1),
                      width: 0.25,
                      spacing: 0.1,
                      dataSource: _testChartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ])),
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text("Test results for courses",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SfCartesianChart(
                isTransposed: true,
                primaryXAxis: CategoryAxis(),
                primaryYAxis: CategoryAxis(
                  minimum: 0,
                  maximum: 100,
                  interval: 20,
                ),
                series: <ChartSeries>[
                  BarSeries<ChartData, String>(
                      color: const Color.fromRGBO(56, 179, 158, 1),
                      width: 0.25,
                      spacing: 0.1,
                      dataSource: _testChartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ])),
        const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text("Time spent by students on courses",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(93, 92, 99, 1)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SfCartesianChart(
                isTransposed: true,
                primaryXAxis: CategoryAxis(),
                primaryYAxis: CategoryAxis(
                  minimum: 0,
                  maximum: 100,
                  interval: 20,
                ),
                series: <ChartSeries>[
                  BarSeries<ChartData, String>(
                      color: const Color.fromRGBO(56, 179, 158, 1),
                      width: 0.25,
                      spacing: 0.1,
                      dataSource: _testChartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y)
                ])),
      ],
    );
  }
}
