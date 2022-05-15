import 'package:diplom/models/course.dart';
import 'package:equatable/equatable.dart';

abstract class AllCoursesState extends Equatable {
  const AllCoursesState();

  @override
  List<Object?> get props => [];
}

class AllCoursesInitial extends AllCoursesState {}

class AllCoursesLoading extends AllCoursesState {}

class AllCoursesLoaded extends AllCoursesState {
  final List<ShortCourse> courses;
  const AllCoursesLoaded(this.courses);
}

class AllCoursesError extends AllCoursesState {
  final String? message;
  const AllCoursesError(this.message);
}