import 'dart:ui';

import 'package:diplom/api/courses.dart';
import 'package:diplom/blocs/allUsersLogs/all_users_logs_bloc.dart';
import 'package:diplom/blocs/allUsersLogs/all_users_logs_event.dart';
import 'package:diplom/blocs/allUsersLogs/all_users_logs_state.dart';
import 'package:diplom/blocs/allUsersTests/all_users_tests_bloc.dart';
import 'package:diplom/blocs/allUsersTests/all_users_tests_event.dart';
import 'package:diplom/blocs/allUsersTests/all_users_tests_state.dart';
import 'package:diplom/blocs/users/users_bloc.dart';
import 'package:diplom/blocs/users/users_event.dart';
import 'package:diplom/blocs/users/users_state.dart';
import 'package:diplom/models/course.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/navigation/constants/nav_bar_items.dart';
import 'package:diplom/navigation/navigation_cubit.dart';
import 'package:diplom/navigation/navigation_state.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:diplom/widgects/all_courses_widget.dart';
import 'package:diplom/widgects/diagrams_widget.dart';
import 'package:diplom/widgects/statistics_widget.dart';
import 'package:diplom/widgects/weekly_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'achievement_widget.dart';
import 'weekly_charts_widget.dart';

class PageProviderWidget extends StatefulWidget {
  final List<ShortCourse> courses;
  final AllUsersLogsBloc usersLogsBloc;
  final AllUsersTestsBloc usersTestsBloc;
  final UsersBloc usersBloc;

  const PageProviderWidget({Key? key,
    required this.courses,
    required this.usersLogsBloc,
    required this.usersTestsBloc,
    required this.usersBloc
  })
      : super(key: key);

  @override
  State<PageProviderWidget> createState() => _PageProviderWidget();
}

class _PageProviderWidget extends State<PageProviderWidget> {
  final List<Course> _allCourse = <Course>[];
  void initPageState() async {
    List<Course> fetchesCourses = <Course>[];
    for(ShortCourse course in widget.courses) {
      final resultCourse = await fetchCoursesByName(course.course);
      fetchesCourses.add(resultCourse);
    }
    setState(() {
      _allCourse.addAll(fetchesCourses);
    });
  }

  @override
  void initState() {
    initPageState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    widget.usersLogsBloc.add(const GetAllUsersLogs());
    widget.usersTestsBloc.add(const GetAllUsersTests());
    widget.usersBloc.add(const GetUsers());
    return BlocBuilder<AllUsersLogsBloc, AllUsersLogsState>(
        builder: (context, usersLogsState) {
          if (usersLogsState is AllUsersLogsLoaded) {
            return BlocBuilder<AllUsersTestsBloc, AllUsersTestsState>(
                builder: (context, usersTestsState) {
                  if (usersTestsState is AllUsersTestsLoaded) {
                    return BlocBuilder<UsersBloc, UsersState>(
                        builder: (context, usersState) {
                          if (usersState is UsersLoaded) {
                            return  BlocBuilder<NavigationCubit, NavigationState>(
                                builder: (context, state) {
                                  if (state.navbarItem == NavbarItem.statistics) {
                                    return Column(
                                        children: [
                                          AllCourses(courses: _allCourse, usersLogs: usersLogsState.usersLogs, tests: usersTestsState.userTests, users: usersState.users)
                                        ]
                                    );
                                  } else if (state.navbarItem == NavbarItem.progress) {
                                    return Column(
                                        children: [
                                          DiagramsWidget(courses: _allCourse, usersLogs: usersLogsState.usersLogs, tests: usersTestsState.userTests, users: usersState.users)
                                        ],
                                    );
                                  } else if (state.navbarItem == NavbarItem.history) {
                                      return Column(
                                        children: [
                                          WeeklyChartsWidget(courses: _allCourse, usersLogs: usersLogsState.usersLogs, tests: usersTestsState.userTests, users: usersState.users)
                                        ],
                                      );
                                  }
                                  return Container();
                                }
                            );
                          } else {
                            return Container();
                          }
                        });
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        });
  }
}

