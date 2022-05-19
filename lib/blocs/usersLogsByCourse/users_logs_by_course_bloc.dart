import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/usersLogsByCourse/users_logs_by_course_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'users_logs_by_course_state.dart';

class UsersLogsByCoursesBloc extends Bloc<UsersLogsByCoursesEvent, UsersLogsByCoursesState> {
  UsersLogsByCoursesBloc() : super(UsersLogsByCoursesInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetUsersLogsByCoursesFromTime>((event, emit) async {
      try {
        emit(UsersLogsByCoursesLoading());
        final usersLogs = await _userRepository.getUsersLogsByCoursesFromTime(event.users);
        emit(UsersLogsByCoursesLoaded(usersLogs));
      } catch (_) {
        emit(const UsersLogsByCoursesError("Failed to fetch data"));
      }
    });
  }
}