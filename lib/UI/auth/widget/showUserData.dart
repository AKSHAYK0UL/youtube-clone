import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube/UI/Home/bottom_nav.dart';
import 'package:youtube/UI/auth/screen/signin.dart';

class ShowScreenOnUserData extends StatefulWidget {
  static const routeName = 'ShowScreenOnUserData';

  const ShowScreenOnUserData({super.key});

  @override
  State<ShowScreenOnUserData> createState() => _ShowScreenOnUserDataState();
}

class _ShowScreenOnUserDataState extends State<ShowScreenOnUserData> {
  @override
  Widget build(BuildContext context) {
    final supabaseInstance = Supabase.instance.client;

    return StreamBuilder<AuthState?>(
      stream: supabaseInstance.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data?.session != null && data?.event != AuthChangeEvent.signedOut) {
          return const BottomNav();
        }
        return const SignIn();
      },
    );
  }
}
