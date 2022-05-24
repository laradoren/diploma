import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/users/users_event.dart';
import 'package:diplom/blocs/users/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetUsers>((event, emit) async {
      try {
        emit(UsersLoading());
        final user = await _userRepository.getAllUsers();
        emit(UsersLoaded(user));
      } catch (_) {
        emit(const UsersError("Logout"));
      }
    });
  }
}