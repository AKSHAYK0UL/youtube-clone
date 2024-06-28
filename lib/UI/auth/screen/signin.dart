import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/UI/auth/widget/signin_textfield.dart';
import 'package:youtube/UI/widget/snackbar.dart';
import 'package:youtube/bloc/authbloc/auth_bloc.dart';

class SignIn extends StatefulWidget {
  static const routeName = "SignIn";
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthenticationState>(
              listener: (context, state) {
            if (state is AuthFailureState) {
              context.read<AuthBloc>().add(AuthInitialEvent());

              ShowSnackbar(context, state.error);
            }
          }, builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.040),
              child: buildSignInTextField(context, screenSize),
            );
          }),
        ),
      ),
    );
  }
}
