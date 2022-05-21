import 'package:diplom/models/test.dart';
import 'package:equatable/equatable.dart';

import '../../models/user.dart';

abstract class CourseUsersState extends Equatable {
  const CourseUsersState();

  @override
  List<Object?> get props => [];
}

class CourseUsersInitial extends CourseUsersState {}

class CourseUsersLoading extends CourseUsersState {}

class CourseUsersLoaded extends CourseUsersState {
  final List<UserInfo> courseUsers;
  const CourseUsersLoaded(this.courseUsers);
}

class CourseUsersError extends CourseUsersState {
  final String? message;
  const CourseUsersError(this.message);
}