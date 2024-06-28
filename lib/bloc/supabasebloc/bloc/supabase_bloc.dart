import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube/model/video_model/video_class.dart';

part 'supabase_event.dart';
part 'supabase_state.dart';

class SupabaseBloc extends Bloc<SupabaseEvent, SupabaseState> {
  SupabaseBloc() : super(SupabaseInitial()) {
    on<UploadImage>(_uploadImage);
    on<FetchVideos>(_fetchvideos);
  }
  final supabaseClient = Supabase.instance.client;

  Future<void> _uploadImage(
      UploadImage event, Emitter<SupabaseState> emit) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return; //show snackbar
    }

    final uploadImage = File(image.path);
    try {
      final userid = supabaseClient.auth.currentUser!.id;
      final imagePath = "/$userid/userprofile/${image.name}";
      await supabaseClient.storage
          .from("userprofile")
          .upload(imagePath, uploadImage);
      final imageUrl =
          supabaseClient.storage.from("userprofile").getPublicUrl(imagePath);

      await supabaseClient.auth.updateUser(
        UserAttributes(data: {"userprofile": imageUrl}),
      );
      emit(ImageUrlState(imageUrl));
    } catch (e) {
      //add error
    }
  }

  Future<void> _fetchvideos(
      FetchVideos event, Emitter<SupabaseState> emit) async {
    emit(LoadingState());
    try {
      final response = await supabaseClient.from('videos').select();

      final List<Video> videos =
          response.map((e) => Video.fromJson(e)).toList();
      emit(VideoList(videos));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
