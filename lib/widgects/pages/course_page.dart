import 'dart:ui';

import 'package:diplom/blocs/courseTests/course_tests_bloc.dart';
import 'package:diplom/blocs/courseTests/course_tests_state.dart';
import 'package:diplom/blocs/user/user_bloc.dart';
import 'package:diplom/blocs/user/user_state.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_bloc.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_state.dart';
import 'package:diplom/blocs/userLogs/user_logs_bloc.dart';
import 'package:diplom/blocs/userLogs/user_logs_state.dart';
import 'package:diplom/blocs/weekLogs/week_logs_bloc.dart';
import 'package:diplom/blocs/weekLogs/week_logs_state.dart';
import 'package:diplom/widgects/diagram_widget.dart';
import 'package:diplom/widgects/profile.dart';
import 'package:diplom/widgects/rare_achievements_widget.dart';
import 'package:diplom/widgects/statistic_widjet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/chart_data.dart';
import '../../models/course.dart';
import '../../models/test.dart';
import '../../utils/calculator.dart';

class CoursePage extends StatefulWidget {
  final List<CourseUser> users;
  final List<Test> tests;
  final String courseName;

  const CoursePage(
      {Key? key,
      required this.users,
      required this.tests,
      required this.courseName})
      : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with TickerProviderStateMixin {
  static List<ChartData> _testChartData = <ChartData>[];

  @override
  void initState() {
    Calculator calculator = Calculator();
    _testChartData = calculator.calculateTestsGapsChartData(widget.tests);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
        toolbarHeight: 54,
        title: Text(widget.courseName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TabBar(
            labelColor: const Color.fromRGBO(41, 215, 41, 1),
            unselectedLabelColor: const Color.fromRGBO(140, 138, 149, 1),
            indicatorColor: const Color.fromRGBO(41, 215, 41, 1),
            padding: const EdgeInsets.all(0),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            controller: _tabController,
            tabs: const [
              Tab(text: 'INFO', height: 32),
              Tab(text: 'DIAGRAMS', height: 32)
            ],
          ),
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height - 292,
            child: TabBarView(
              controller: _tabController,
              children: [
                Builder(builder: (context) {
                }),
                SingleChildScrollView(
                  child: Builder(
                      builder: (context) {
                        return DiagramWidget(header: "Test results for courses", data: _testChartData, height: widget.tests.length);
                      }
                  ),
                ),
              ],
            ),
          ),
          // RareAchievements(),
        ],
      ),
    );
  }
}
