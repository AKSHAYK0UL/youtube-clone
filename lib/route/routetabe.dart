import 'package:flutter/material.dart';
import 'package:youtube/UI/Home/homescreen.dart';
import 'package:youtube/UI/Home/video_screen.dart';
import 'package:youtube/UI/auth/screen/resetpassword.dart';
import 'package:youtube/UI/auth/screen/signin.dart';
import 'package:youtube/UI/auth/screen/signup.dart';
import 'package:youtube/UI/auth/screen/token_screen.dart';

Map<String, WidgetBuilder> routeTable = {
  ResetPassword.routeName: (context) => const ResetPassword(),
  SignIn.routeName: (context) => const SignIn(),
  SignUp.routeName: (context) => const SignUp(),
  TokenScreen.routeName: (context) => const TokenScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  VideoScreen.routeName: (context) => const VideoScreen(),
};
