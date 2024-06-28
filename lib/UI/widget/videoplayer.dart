import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube/UI/Home/video_screen.dart';
import 'package:youtube/UI/widget/list_tile.dart';
import 'package:youtube/model/video_model/video_class.dart';

class VideoPlayer extends StatefulWidget {
  final List<Video> videoList;
  const VideoPlayer(this.videoList, {super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late Future<void> _loadVideosFuture;

  @override
  void initState() {
    _loadVideosFuture = loadAllVideos();
    super.initState();
  }

  Future<void> loadAllVideos() async {
    List<Future<void>> futures = widget.videoList.map((video) async {
      PodPlayerController controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(video.videoUrl),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,
          videoQualityPriority: [1080, 720, 480, 360],
        ),
      );
      await controller.initialise();
      video.controller = controller;
    }).toList();

    await Future.wait(futures);
  }

  @override
  void dispose() {
    for (var video in widget.videoList) {
      video.controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadVideosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error loading videos"),
          );
        } else {
          return ListView.builder(
            itemCount: widget.videoList.length,
            itemBuilder: (context, index) {
              final video = widget.videoList[index];
              return Container(
                margin: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      PodVideoPlayer(
                        overlayBuilder: (options) {
                          final duration = options.videoDuration;
                          String formattedDuration =
                              "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                VideoScreen.routeName,
                                arguments: {
                                  "mainController": video.controller,
                                  "mainvideodata": video,
                                  "otherControllers": widget.videoList
                                      .where((v) => v != video)
                                      .map((v) => v.controller)
                                      .toList(),
                                  "othervideodata": widget.videoList
                                      .where((v) => v != video)
                                      .map((v) => v)
                                      .toList(),
                                },
                              );
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(
                                    formattedDuration,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        controller: video.controller!,
                        onLoading: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      buildListTile(
                          context: context,
                          VideoName: video.videoName,
                          VideoUrl: video.videoUrl,
                          UploadedBy: video.uploadedBy,
                          UploadedAt: video.uploadedAt),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
