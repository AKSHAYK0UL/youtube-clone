import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube/UI/auth/widget/showUserData.dart';
import 'package:youtube/bloc/authbloc/auth_bloc.dart';
import 'package:youtube/bloc/supabasebloc/bloc/supabase_bloc.dart';
import 'package:youtube/route/routetabe.dart';
import 'package:youtube/secrets/apikey.dart';
import 'package:youtube/theme/themedata.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => SupabaseBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(context),
        home: const ShowScreenOnUserData(),
        routes: routeTable,
      ),
    );
  }
}
