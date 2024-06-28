import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthInitialEvent>(_initial);
    on<AuthSignUpEvent>(_signUp);
    on<AuthLoginEvent>(_login);
    on<GetToken>(_getToken);
    on<AuthResetPassswordEvent>(_reset);
  }

  final supabaseInstance = Supabase.instance.client;

  void _initial(AuthInitialEvent event, Emitter<AuthenticationState> emit) {
    emit(AuthInitial());
    return;
  }

  Future<void> _signUp(
      AuthSignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());

    try {
      final response = await supabaseInstance.auth.signUp(
        email: event.email.trim(),
        password: event.password.trim(),
        emailRedirectTo: "verifyuser.youtube://login-callback/",
        data: {
          "username": event.name,
          "userprofile": "",
        },
      );

      final currentUser = response.user;
      if (currentUser != null) {
        await supabaseInstance.from("users").insert({
          "id": currentUser.id,
          "email": currentUser.email,
          "username": currentUser.userMetadata?["username"],
          "created_at": DateTime.now().toUtc().toIso8601String(),
        });
      }

      emit(AuthSuccessState());
      return;
    } on AuthException catch (e) {
      emit(AuthFailureState(e.message.toString()));

      return;
    }
  }

  Future<void> _login(
      AuthLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());
    try {
      await supabaseInstance.auth
          .signInWithPassword(email: event.email, password: event.password);
      emit(AuthSuccessState());
    } on AuthException catch (e) {
      emit(AuthFailureState(e.message.toString()));
    }
  }

  Future<void> _getToken(
      GetToken event, Emitter<AuthenticationState> emit) async {
    emit(ResetLoadingState());
    try {
      await supabaseInstance.auth.resetPasswordForEmail(
        event.email,
      );
      emit(AuthSuccessState());
    } catch (_) {}
  }

  Future<void> _reset(
      AuthResetPassswordEvent event, Emitter<AuthenticationState> emit) async {
    emit(ResetLoadingState());
    try {
      print(
          "EMAIl ${event.email} Passsword ${event.password} Tokenkk ${event.token}");

      await supabaseInstance.auth.verifyOTP(
        email: event.email,
        token: event.token,
        type: OtpType.recovery,
      );

      final response = await supabaseInstance.auth.updateUser(
        UserAttributes(
          password: event.password,
        ),
      );

      final currentUser = response.user;
      if (currentUser != null) {
        await supabaseInstance.from("users").update({
          "updated_at": DateTime.now().toUtc().toIso8601String(),
        }).eq('id', currentUser.id);
      }

      emit(AuthSuccessState());
      return;
    } on AuthException catch (e) {
      emit(AuthFailureState(e.message.toString()));
      return;
    }
  }
}
