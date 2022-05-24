import 'package:equatable/equatable.dart';

abstract class AllUsersLogsEvent extends Equatable {
  const AllUsersLogsEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersLogs extends AllUsersLogsEvent {
  const GetAllUsersLogs();
}