import 'package:diplom/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserInfo> users;
  const UsersLoaded(this.users);
}

class UsersError extends UsersState {
  final String? message;
  const UsersError(this.message);
}