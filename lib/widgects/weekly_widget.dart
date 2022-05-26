import 'dart:ui';

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
import 'package:diplom/widgects/weekly_charts_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weekly_text_row_widget.dart';

class Weekly extends StatelessWidget {
  final List<ShortCourse> courses;
  final AllUsersLogsBloc usersLogsBloc;
  final AllUsersTestsBloc usersTestsBloc;
  final UsersBloc usersBloc;

  const Weekly({Key? key,
    required this.courses,
    required this.usersLogsBloc,
    required this.usersTestsBloc,
    required this.usersBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    usersLogsBloc.add(const GetAllUsersLogs());
    usersTestsBloc.add(const GetAllUsersTests());
    usersBloc.add(const GetUsers());
    final allCoursesDetail =
    BlocProvider.of<AllUsersTestsBloc>(context);
    return Column(
      children: [
        BlocBuilder<AllUsersLogsBloc, AllUsersLogsState>(
            builder: (context, usersLogsState) {
              if (usersLogsState is AllUsersLogsLoaded) {
                return BlocBuilder<AllUsersTestsBloc, AllUsersTestsState>(
                    builder: (context, usersTestsState) {
                      if (usersTestsState is AllUsersTestsLoaded) {
                        return BlocBuilder<UsersBloc, UsersState>(
                            builder: (context, usersState) {
                              if (usersState is UsersLoaded) {
                                return Container();
                              } else {
                                return _buildLoading();
                              }
                            });
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Container();
              }
            }),
      ],
    );
  }
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}