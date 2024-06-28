import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/UI/Home/bottom_nav.dart';
import 'package:youtube/UI/auth/widget/token_textfiled.dart';
import 'package:youtube/bloc/authbloc/auth_bloc.dart';

import 'package:youtube/model/authmodel/signupreq.dart';

class TokenScreen extends StatefulWidget {
  static const routeName = "TokenScreen";
  const TokenScreen({super.key});

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final routeData = ModalRoute.of(context)!.settings.arguments as SignUpReq;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return const BottomNav();
              }), (route) => false);
            }
            if (state is LoadingState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            }
            if (state is AuthFailureState) {
              Navigator.of(context).pop();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.0500,
                ),
                child: ElevatedButton.icon(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.resolveWith(
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
              buildTokenTextField(context, screenSize, routeData),
            ],
          ),
        ),
      ),
    );
  }
}
