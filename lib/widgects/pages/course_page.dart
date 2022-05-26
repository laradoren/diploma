import 'dart:ui';

import 'package:diplom/models/log.dart';
import 'package:diplom/models/user.dart';
import 'package:diplom/models/users_logs_by_course.dart';
import 'package:diplom/models/course.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/blocs/courseUsers/course_users_bloc.dart';
import 'package:diplom/blocs/courseUsers/course_users_state.dart';
import 'package:diplom/widgects/charts_widget.dart';
import 'package:diplom/widgects/users_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursePage extends StatefulWidget {
  final Course course;
  final List<UserLog> usersLogs;
  final List<Test> tests;
  final List<UserInfo> users;

  const CoursePage(
      {Key? key,
      required this.course,
      required this.usersLogs,
      required this.tests,
      required this.users})
      : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
        toolbarHeight: 54,
        title: Text(widget.course.course.caption,
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
              Tab(text: 'CHARTS', height: 32)
            ],
          ),
          Container(
            width: double.maxFinite-34,
            height: MediaQuery.of(context).size.height-88,
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Builder(
                      builder: (context) {
                        return UsersInfo(course: widget.course, users: widget.users, usersLogs: widget.usersLogs);
                      }
                  ),
                ),
                SingleChildScrollView(
                  child: Builder(
                      builder: (context) {
                        return ChartsWidget(branches: widget.course.branches, usersLogs: widget.usersLogs, tests: widget.tests, users: widget.users);
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
