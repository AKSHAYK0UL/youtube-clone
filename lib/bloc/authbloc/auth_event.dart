part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthInitialEvent extends AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpEvent(
      {required this.name, required this.email, required this.password});
}

final class AuthLoginEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  AuthLoginEvent(
      {required this.context, required this.email, required this.password});
}

final class GetToken extends AuthEvent {
  final String email;
  GetToken(this.email);
}

final class AuthResetPassswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String token;

  AuthResetPassswordEvent(
      {required this.email, required this.password, required this.token});
}
