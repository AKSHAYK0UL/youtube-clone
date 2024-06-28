part of 'supabase_bloc.dart';

sealed class SupabaseEvent {}

final class UploadImage extends SupabaseEvent {
  final BuildContext context;
  UploadImage(this.context);
}

final class FetchVideos extends SupabaseEvent {}
