import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/allUsersLogs/all_users_logs_event.dart';
import 'package:diplom/blocs/allUsersLogs/all_users_logs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersLogsBloc extends Bloc<AllUsersLogsEvent, AllUsersLogsState> {
  AllUsersLogsBloc() : super(AllUsersLogsInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetAllUsersLogs>((event, emit) async {
      try {
        emit(AllUsersLogsLoading());
        final usersLogs = await _userRepository.getAllUsersLogs();
        emit(AllUsersLogsLoaded(usersLogs));
      } catch (_) {
        emit(const AllUsersLogsError("Failed to fetch data"));
      }
    });
  }
}