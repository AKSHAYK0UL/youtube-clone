part of 'auth_bloc.dart';

sealed class AuthenticationState {}

final class AuthInitial extends AuthenticationState {}

final class LoadingState extends AuthenticationState {}

final class ResetLoadingState extends AuthenticationState {}

final class AuthSuccessState extends AuthenticationState {}

final class AuthFailureState extends AuthenticationState {
  String error;
  AuthFailureState(this.error);
}
