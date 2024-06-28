part of 'supabase_bloc.dart';

sealed class SupabaseState {}

final class SupabaseInitial extends SupabaseState {}

final class ErrorState extends SupabaseState {
  final String error;
  ErrorState(this.error);
}

final class LoadingState extends SupabaseState {}

final class ImageUrlState extends SupabaseState {
  final String url;
  ImageUrlState(this.url);
}

final class VideoList extends SupabaseState {
  final List<Video> videolist;
  VideoList(this.videolist);
}
