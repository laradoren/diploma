import 'package:diplom/models/test.dart';
import 'package:equatable/equatable.dart';

abstract class AllUsersTestsState extends Equatable {
  const AllUsersTestsState();

  @override
  List<Object?> get props => [];
}

class AllUsersTestsInitial extends AllUsersTestsState {}

class AllUsersTestsLoading extends AllUsersTestsState {}

class AllUsersTestsLoaded extends AllUsersTestsState {
  final List<Test> userTests;
  const AllUsersTestsLoaded(this.userTests);
}

class AllUsersTestsError extends AllUsersTestsState {
  final String? message;
  const AllUsersTestsError(this.message);
}