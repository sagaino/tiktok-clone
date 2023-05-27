import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoFile;
  const CustomVideoPlayer({
    super.key,
    required this.videoFile,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? playerController;

  @override
  void initState() {
    print("init custom video player");
    playerController = VideoPlayerController.network(widget.videoFile)
      ..initialize().then(
        (value) {
          playerController!.play();
          playerController!.setLooping(true);
          playerController!.setVolume(2);
        },
      );

    super.initState();
  }

  @override
  void dispose() {
    print("dispose custom video player");
    playerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: VideoPlayer(
        playerController!,
      ),
    );
  }
}
