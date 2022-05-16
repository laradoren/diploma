import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String login;
  final String? role;

  const AuthUser({
    required this.login,
    required this.role,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      login: json['login'],
      role: json['role'],
    );
  }

  @override
  List<Object> get props => [login];

  static const empty = AuthUser(login: "-", role: "-");
}