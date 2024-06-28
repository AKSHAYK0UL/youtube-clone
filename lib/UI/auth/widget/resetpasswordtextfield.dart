import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/UI/auth/screen/token_screen.dart';

import 'package:youtube/bloc/authbloc/auth_bloc.dart';
import 'package:youtube/model/authmodel/signupreq.dart';

final _formKey = GlobalKey<FormState>();
Future<void> onNextTap(
  BuildContext context,
  SignUpReq authobj,
) async {
  final valid = _formKey.currentState!.validate();
  if (!valid) {
    return;
  }
  _formKey.currentState!.save();
  FocusManager.instance.primaryFocus!.unfocus();
  context.read<AuthBloc>().add(GetToken(authobj.email));
  Future.delayed(const Duration(seconds: 5), () {
    Navigator.of(context).pushNamed(TokenScreen.routeName, arguments: authobj);
  });
}

Widget buildResetPasswordTextField(BuildContext context, Size screenSize) {
  SignUpReq authobj = SignUpReq(username: "", email: "", password: "");
  bool showPassword = true;
  return Container(
    margin: EdgeInsets.only(
        top: screenSize.height * 0.0547,
        left: screenSize.height * 0.020,
        right: screenSize.height * 0.020),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Reset Password",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.0527,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter email";
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenSize.height * 0.016,
                vertical: screenSize.height * 0.020,
              ),
              hintText: "Enter your email",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueGrey.shade100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueGrey.shade800),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red.shade300),
              ),
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.blueGrey.shade500),
            ),
            textInputAction: TextInputAction.next,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: screenSize.height * 0.032),
            onSaved: (newValue) {
              authobj.email = newValue!;
            },
          ),
          SizedBox(
            height: screenSize.height * 0.0267,
          ),
          StatefulBuilder(
            builder: (context, setState) => TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter new password";
                }
                if (value.length < 8) {
                  return "Password should be ≥ 8 chars long";
                }
                return null;
              },
              obscureText: showPassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenSize.height * 0.016,
                  vertical: screenSize.height * 0.020,
                ),
                hintText: "Enter new password",
                filled: true,
                fillColor: Colors.grey.shade100,
                suffixIcon: IconButton(
                  icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(
                      () {
                        showPassword = !showPassword;
                      },
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueGrey.shade50),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueGrey.shade100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueGrey.shade800),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red.shade300),
                ),
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.blueGrey.shade500),
              ),
              textInputAction: TextInputAction.done,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: screenSize.height * 0.032),
              onSaved: (newValue) {
                authobj.password = newValue!;
              },
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.0533,
          ),
          BlocBuilder<AuthBloc, AuthenticationState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return SizedBox(
                height: screenSize.height * 0.0747,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: state is LoadingState
                      ? null
                      : () async {
                          await onNextTap(context, authobj);
                        },
                  child: Text(
                    state is LoadingState ? "Next" : "Next",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: screenSize.height * 0.0213,
                        color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
