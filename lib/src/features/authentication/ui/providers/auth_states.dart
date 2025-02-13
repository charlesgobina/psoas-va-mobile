import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthSuccess extends AuthStates {
  final User user;

  AuthSuccess(this.user);
}

class AuthFailure extends AuthStates {
  final String message;

  AuthFailure(this.message);
}