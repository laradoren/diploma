import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/courseTests/course_tests_event.dart';
import 'package:diplom/blocs/courseTests/course_tests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_users_event.dart';
import 'course_users_state.dart';

class CourseUsersBloc extends Bloc<CourseUsersEvent, CourseUsersState> {
  CourseUsersBloc() : super(CourseUsersInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetCourseUsers>((event, emit) async {
      try {
        emit(CourseUsersLoading());
        final courseUsers = await _userRepository.getCourseUsers(event.users);
        emit(CourseUsersLoaded(courseUsers));
      } catch (_) {
        emit(const CourseUsersError("Failed to fetch data"));
      }
    });
  }
}