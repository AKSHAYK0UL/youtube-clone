import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/UI/widget/videoplayer.dart';
import 'package:youtube/bloc/supabasebloc/bloc/supabase_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<SupabaseBloc>().add(FetchVideos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Home'),
      ),
      body: BlocBuilder<SupabaseBloc, SupabaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is VideoList) {
            return VideoPlayer(state.videolist);
          }
          return const Text("");
        },
      ),
    );
  }
}
