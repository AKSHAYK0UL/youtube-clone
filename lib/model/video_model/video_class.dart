import 'package:pod_player/pod_player.dart';

class Video {
  final String videoId;
  final String videoUrl;
  final String videoName;
  final String uploadedBy;
  final DateTime uploadedAt;
  PodPlayerController? controller;

  Video({
    required this.videoId,
    required this.videoUrl,
    required this.videoName,
    required this.uploadedBy,
    required this.uploadedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoId: json['id'],
      videoUrl: json['url'],
      videoName: json['video_name'],
      uploadedBy: json['uploaded_by'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': videoId,
      'url': videoUrl,
      'video_name': videoName,
      'uploaded_by': uploadedBy,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }
}
