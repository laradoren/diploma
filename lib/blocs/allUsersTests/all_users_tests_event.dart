import 'package:equatable/equatable.dart';

abstract class AllUsersTestsEvent extends Equatable {
  const AllUsersTestsEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersTests extends AllUsersTestsEvent {
  const GetAllUsersTests();
}