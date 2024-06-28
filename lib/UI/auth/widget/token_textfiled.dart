import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/bloc/authbloc/auth_bloc.dart';
import 'package:youtube/model/authmodel/signupreq.dart';

final _formKey = GlobalKey<FormState>();

Future<void> onNextTap({
  required BuildContext context,
  required SignUpReq authobj,
}) async {
  final valid = _formKey.currentState!.validate();
  if (!valid) {
    return;
  }
  _formKey.currentState!.save();
  FocusManager.instance.primaryFocus!.unfocus();

  context.read<AuthBloc>().add(AuthResetPassswordEvent(
      email: authobj.email,
      password: authobj.password,
      token: authobj.username));
}

Widget buildTokenTextField(
    BuildContext context, Size screenSize, SignUpReq routeData) {
  return Container(
    margin: EdgeInsets.only(
      top: screenSize.height * 0.0547,
      left: screenSize.height * 0.020,
      right: screenSize.height * 0.020,
    ),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Verification code",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          Text(
            "Enter the verification code that has been send to your email",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(
            height: screenSize.height * 0.0333,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter code";
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenSize.height * 0.016,
                vertical: screenSize.height * 0.020,
              ),
              hintText: "Enter code",
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
            textInputAction: TextInputAction.done,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: screenSize.height * 0.032),
            onSaved: (newValue) {
              routeData.username = newValue!;
            },
          ),
          SizedBox(
            height: screenSize.height * 0.0433,
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
                          await onNextTap(context: context, authobj: routeData);
                        },
                  child: Text(
                    "Reset",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: screenSize.height * 0.0213,
                          color: Colors.white,
                        ),
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
