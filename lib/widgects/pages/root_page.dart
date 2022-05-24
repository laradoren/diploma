import 'package:diplom/blocs/allCourses/all_courses_bloc.dart';
import 'package:diplom/blocs/allCourses/all_courses_event.dart';
import 'package:diplom/widgects/pages/teacher_cabinet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final allCoursesBloc = BlocProvider.of<AllCoursesBloc>(context);
    return Builder(
      builder: (context) {
        allCoursesBloc.add(const GetAllCourses());

        return const TeacherCabinetPage();
      },
    );
  }
}
