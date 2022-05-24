import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/allUsersTests/all_users_tests_event.dart';
import 'package:diplom/blocs/allUsersTests/all_users_tests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersTestsBloc extends Bloc<AllUsersTestsEvent, AllUsersTestsState> {
  AllUsersTestsBloc() : super(AllUsersTestsInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetAllUsersTests>((event, emit) async {
      try {
        emit(AllUsersTestsLoading());
        final userTests = await _userRepository.getAllUsersTestsResult();
        emit(AllUsersTestsLoaded(userTests));
      } catch (_) {
        emit(const AllUsersTestsError("Failed to fetch data"));
      }
    });
  }
}