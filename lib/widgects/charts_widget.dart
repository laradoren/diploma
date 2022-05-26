import 'dart:ui';

import 'package:diplom/api/branch.dart';
import 'package:diplom/blocs/courseUsers/course_users_bloc.dart';
import 'package:diplom/models/chart_data.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/models/users_logs_by_course.dart';
import 'package:diplom/widgects/diagram_widget.dart';
import 'package:diplom/widgects/user_info_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/courseUsers/course_users_state.dart';
import '../models/course.dart';
import '../models/user.dart';
import '../utils/calculator.dart';
import 'weekly_text_row_widget.dart';

class ChartsWidget extends StatefulWidget {
  final List<UserInfo> users;
  final List<Test> tests;
  final List<UserLog> usersLogs;
  final List branches;

  const ChartsWidget({Key? key, required this.users, required this.tests,required this.usersLogs, required this.branches}) : super(key: key);

  @override
  State<ChartsWidget> createState() => _ChartsWidgetState();

}
class _ChartsWidgetState extends State<ChartsWidget> with TickerProviderStateMixin {
  static List<ChartData> _testChartData = <ChartData>[];
  static List<ChartData> _timeChartData = <ChartData>[];
  static List<ChartData> _timeBranchChartData = <ChartData>[];
  static List<ChartData> _testBranchChartData = <ChartData>[];
  static int _heightTests = 0;
  static int _heightTime = 0;
  static int _heightTimeBranch = 0;
  static int _heightTestBranch = 0;
  @override
  void initState() {
    Calculator calculator = Calculator();
    _testChartData = calculator.calculateTestsGapsChartData(widget.tests);
    _timeChartData = calculator.calculateTimeGapsChartData(widget.usersLogs);
    _timeBranchChartData = calculator.calculateTimeBranchGapsChartData(widget.usersLogs, widget.branches);
    _testBranchChartData = calculator.calculateTestBranchGapsChartData(widget.tests, widget.branches);
    _heightTests = calculator.calculateHeightOfChart(_testChartData);
    _heightTime = calculator.calculateHeightOfChart(_timeChartData);
    _heightTimeBranch = calculator.calculateHeightOfChart(_timeBranchChartData);
    _heightTestBranch = calculator.calculateHeightOfChart(_testBranchChartData);
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
                child: Text("Detail information represented by charts",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(93, 92, 99, 1)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  DiagramWidget(header: "Test results for courses", data: _testChartData, height: _heightTests),
                  DiagramWidget(header: "Time spent on course", data: _timeChartData, height: _heightTime),
                  //DiagramWidget(header: "Average tests results on separate branch", data: _testBranchChartData, height: _heightTestBranch),
                  DiagramWidget(header: "Time spend on separate branch", data: _timeBranchChartData, height: _heightTimeBranch)
                ]
              ),
            ),
          ],
        ));
  }
}