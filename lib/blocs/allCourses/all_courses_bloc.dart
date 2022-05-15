import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/allCourses/all_courses_event.dart';
import 'package:diplom/blocs/allCourses/all_courses_state.dart';
import 'package:diplom/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCoursesBloc extends Bloc<AllCoursesEvent, AllCoursesState> {
  AllCoursesBloc() : super(AllCoursesInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetAllCourses>((event, emit) async {
      try {
        emit(AllCoursesLoading());
        final List<ShortCourse> courses = await _userRepository.getAllCourses();
        emit(AllCoursesLoaded(courses));
      } catch (_) {
        emit(const AllCoursesError("Failed to fetch data"));
      }
    });
  }
}