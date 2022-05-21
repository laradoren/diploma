import 'package:diplom/models/course.dart';
import 'package:diplom/widgects/user_info_row_widget.dart';
import 'package:diplom/widgects/users_info_widget.dart';
import 'package:equatable/equatable.dart';

abstract class CourseUsersEvent extends Equatable {
  const CourseUsersEvent();

  @override
  List<Object> get props => [];
}

class GetCourseUsers extends CourseUsersEvent {
  final List<CourseUser> users;

  const GetCourseUsers({required this.users});
}