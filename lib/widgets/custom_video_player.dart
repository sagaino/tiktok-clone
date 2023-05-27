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
    super.initState();
    print("init custom video player");
    print("init custom video player : ${widget.videoFile}");
    playerController = VideoPlayerController.network(widget.videoFile)
      ..initialize().then(
        (value) {
          playerController!.play();
          playerController!.setLooping(true);
          playerController!.setVolume(2);
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose custom video player");
    playerController!.dispose();
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
