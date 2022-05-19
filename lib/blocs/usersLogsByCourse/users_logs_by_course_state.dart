import 'package:diplom/models/users_logs_by_course.dart';
import 'package:equatable/equatable.dart';

abstract class UsersLogsByCoursesState extends Equatable {
  const UsersLogsByCoursesState();

  @override
  List<Object?> get props => [];
}

class UsersLogsByCoursesInitial extends UsersLogsByCoursesState {}

class UsersLogsByCoursesLoading extends UsersLogsByCoursesState {}

class UsersLogsByCoursesLoaded extends UsersLogsByCoursesState {
  final List<UsersLogsByCourse> usersLogs;
  const UsersLogsByCoursesLoaded(this.usersLogs);
}

class UsersLogsByCoursesError extends UsersLogsByCoursesState {
  final String? message;
  const UsersLogsByCoursesError(this.message);
}