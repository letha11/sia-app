part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class Login extends AuthEvent {
  final String username, password, captcha;

  Login(
      {required this.username, required this.password, required this.captcha});
}

final class Logout extends AuthEvent {}

final class ReLogin extends AuthEvent {
  final String captcha;

  ReLogin({required this.captcha});
}

final class AuthCheckStatus extends AuthEvent {}
