import 'dart:ui';

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
  final List<CourseUser> users;
  final List<Test> tests;
  final List<Test> allUsersTest;
  final String courseName;
  final List<UsersLogsByCourse> usersLogs;
  final List branches;

  const CoursePage(
      {Key? key,
      required this.users,
      required this.tests,
      required this.allUsersTest,
      required this.courseName,
      required this.usersLogs,
      required this.branches})
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
                        return  BlocBuilder<CourseUsersBloc, CourseUsersState>(
                            builder: (context, courseUsersState) {
                              if (courseUsersState is CourseUsersLoaded) {
                                return UsersInfo(branches: widget.branches, courseUsers: courseUsersState.courseUsers, usersLogs: widget.usersLogs);
                              } else {
                                return Container();
                              }
                            });
                      }
                  ),
                ),
                SingleChildScrollView(
                  child: Builder(
                      builder: (context) {
                        return ChartsWidget(branches: widget.branches, usersLogs: widget.usersLogs, tests: widget.tests, users: widget.users, allUsersTest: widget.allUsersTest);
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
