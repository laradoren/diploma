import 'dart:ui';

import 'package:diplom/authentication/authentication.dart';
import 'package:diplom/authentication/authentication_bloc.dart';
import 'package:diplom/blocs/allCourses/all_courses_state.dart';
import 'package:diplom/blocs/allCourses/all_courses_bloc.dart';
import 'package:diplom/blocs/allUsersLogs/all_users_logs_bloc.dart';
import 'package:diplom/blocs/allUsersTests/all_users_tests_bloc.dart';
import 'package:diplom/blocs/users/users_bloc.dart';
import 'package:diplom/navigation/constants/nav_bar_items.dart';
import 'package:diplom/navigation/navigation_cubit.dart';
import 'package:diplom/navigation/navigation_state.dart';
import 'package:diplom/widgects/statistics_widget.dart';
import 'package:diplom/widgects/weekly_widget.dart';
import 'package:diplom/widgects/all_courses_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherCabinetPage extends StatefulWidget {
  const TeacherCabinetPage({Key? key}) : super(key: key);

  @override
  State<TeacherCabinetPage> createState() => _TeacherCabinetPageState();
}

class _TeacherCabinetPageState extends State<TeacherCabinetPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AllCoursesBloc, AllCoursesState>(
          listener: (context, state) => {
            if (state is AllCoursesError)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                )
              }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
          toolbarHeight: 54,
          title: const Text('Professor Cabinet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 8),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BlocBuilder<AllCoursesBloc, AllCoursesState>(
                  builder: (context, coursesState) {
                    if (coursesState is AllCoursesLoaded) {
                      return  Container();
                    } else {
                      return Container();
                    }
                  }
              ),

            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list_rounded ),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.visibility_rounded ),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch_later),
              label: 'Weekly',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromRGBO(41, 215, 41, 1),
          // selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromRGBO(134, 137, 235, 1),
          onTap: (index) {
            DateTime now = DateTime.now();
            _onItemTapped(index);
            if (index == 0) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.statistics);
            } else if (index == 1) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.progress);
            } else if (index == 2) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.history);
            }
          },
          backgroundColor: const Color.fromRGBO(80, 71, 153, 1),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
