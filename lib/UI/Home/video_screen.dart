import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube/UI/widget/list_tile.dart';
import 'package:youtube/model/video_model/video_class.dart';

class VideoScreen extends StatelessWidget {
  static const routeName = "VideoScreen";

  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final mainController = arguments['mainController'];
    final List<PodPlayerController?> otherControllers =
        arguments['otherControllers'];
    final List<Video> otherVideoData = arguments["othervideodata"];
    final Video mainvideoData = arguments["mainvideodata"];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            margin: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PodVideoPlayer(
                    controller: mainController,
                  ),
                  buildListTile(
                      context: context,
                      VideoName: mainvideoData.videoName,
                      VideoUrl: mainvideoData.videoUrl,
                      UploadedBy: mainvideoData.uploadedBy,
                      UploadedAt: mainvideoData.uploadedAt)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: otherControllers.length,
              itemBuilder: (context, index) {
                final data = otherVideoData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            List<Video> newdata = otherVideoData;
                            newdata.add(mainvideoData);
                            Navigator.of(context).pushReplacementNamed(
                              VideoScreen.routeName,
                              arguments: {
                                "mainController": otherControllers[index],
                                "mainvideodata": data,
                                "otherControllers": newdata
                                    .where((v) => v != data)
                                    .map((v) => v.controller)
                                    .toList(),
                                "othervideodata": newdata
                                    .where((v) => v != data)
                                    .map((v) => v)
                                    .toList(),
                              },
                            );
                          },
                          child: PodVideoPlayer(
                            controller: otherControllers[index]!,
                            overlayBuilder: (options) {
                              final duration = options.videoDuration;
                              String formattedDuration =
                                  "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

                              return Container(
                                alignment: Alignment.bottomLeft,
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  formattedDuration,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                        buildListTile(
                            context: context,
                            VideoName: data.videoName,
                            VideoUrl: data.videoUrl,
                            UploadedBy: data.uploadedBy,
                            UploadedAt: data.uploadedAt)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
