import 'package:flutter/widgets.dart';
import 'package:diplom/authentication/authentication_repository.dart';
import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/widgects/app.dart';


void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}