import 'package:diplom/models/log.dart';
import 'package:equatable/equatable.dart';

abstract class AllUsersLogsState extends Equatable {
  const AllUsersLogsState();

  @override
  List<Object?> get props => [];
}

class AllUsersLogsInitial extends AllUsersLogsState {}

class AllUsersLogsLoading extends AllUsersLogsState {}

class AllUsersLogsLoaded extends AllUsersLogsState {
  final List<UserLog> usersLogs;
  const AllUsersLogsLoaded(this.usersLogs);
}

class AllUsersLogsError extends AllUsersLogsState {
  final String? message;
  const AllUsersLogsError(this.message);
}