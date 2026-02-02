import 'package:stylish_ecommerce/models/user_model.dart';

abstract class AuthEvent {}

class Login extends AuthEvent {
  final UserModel user;
  Login(this.user);
}

class SignUp extends AuthEvent {
  final UserModel user;
  SignUp(this.user);
}

class Logout extends AuthEvent {}
