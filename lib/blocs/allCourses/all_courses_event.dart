import 'package:equatable/equatable.dart';

abstract class AllCoursesEvent extends Equatable {
  const AllCoursesEvent();

  @override
  List<Object> get props => [];
}

class GetAllCourses extends AllCoursesEvent {
  const GetAllCourses();
}