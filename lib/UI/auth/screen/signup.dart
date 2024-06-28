import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube/UI/Home/bottom_nav.dart';

import 'package:youtube/UI/auth/widget/dialogbox.dart';
import 'package:youtube/UI/auth/widget/signup_textfield.dart';
import 'package:youtube/UI/widget/snackbar.dart';
import 'package:youtube/bloc/authbloc/auth_bloc.dart';

class SignUp extends StatefulWidget {
  static const routeName = "SignUp";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late StreamSubscription _authSubscription;
  StreamSubscription<AuthState> authChange() {
    final supabaseInstance = Supabase.instance.client;
    return supabaseInstance.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      final User? user = session?.user;

      if (user != null && user.emailConfirmedAt != null) {
        print("SIGNED IN AND EMAIL VERIFIED");
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return const BottomNav();
          }), (route) => false);
        }
      }
    });
  }

  @override
  void initState() {
    _authSubscription = authChange();

    super.initState();
  }

  @override
  void dispose() {
    _authSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                buildDialogBox(
                    context: context,
                    title: "Verify Your Email",
                    content:
                        "A verification email has been sent to your email address ");
              }

              if (state is AuthFailureState) {
                context.read<AuthBloc>().add(AuthInitialEvent());
                ShowSnackbar(context, state.error);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.040),
                child: buildSignUpTextField(context, screenSize),
              );
            },
          ),
        ),
      ),
    );
  }
}
