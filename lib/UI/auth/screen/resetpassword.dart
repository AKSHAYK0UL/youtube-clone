import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/UI/auth/widget/resetpasswordtextfield.dart';
import 'package:youtube/UI/widget/snackbar.dart';
import 'package:youtube/bloc/authbloc/auth_bloc.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = "ResetPassword";
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return PopScope(
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is ResetLoadingState) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  },
                );
              }

              if (state is AuthFailureState) {
                ShowSnackbar(context, state.error);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.height * 0.0200,
                      ),
                      child: ElevatedButton.icon(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => Colors.grey.shade50,
                              ),
                              shape: MaterialStateProperty.resolveWith(
                                (states) => const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    side: BorderSide(color: Colors.black12)),
                              ),
                            ),
                        label: const Text("Back"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    buildResetPasswordTextField(context, screenSize),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      onPopInvoked: (didPop) {
        context.read<AuthBloc>().add(AuthInitialEvent());
      },
    );
  }
}
