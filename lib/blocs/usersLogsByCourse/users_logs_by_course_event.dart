import 'package:diplom/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UsersLogsByCoursesEvent extends Equatable {
  const UsersLogsByCoursesEvent();

  @override
  List<Object> get props => [];
}

class GetUsersLogsByCoursesFromTime extends UsersLogsByCoursesEvent {
  final List users;

  const GetUsersLogsByCoursesFromTime({required this.users});
}