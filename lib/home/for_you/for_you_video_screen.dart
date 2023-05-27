import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/home/for_you/controller_for_you_video.dart';
import 'package:tiktok_clone/widgets/custom_video_player.dart';

class ForYourVideoScreen extends StatefulWidget {
  const ForYourVideoScreen({super.key});

  @override
  State<ForYourVideoScreen> createState() => _ForYourVideoScreenState();
}

class _ForYourVideoScreenState extends State<ForYourVideoScreen> {
  final ControllerForYouVideo controllerVideos =
      Get.put(ControllerForYouVideo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controllerVideos.forYouAllVideoList.length,
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemBuilder: (context, index) {
            final data = controllerVideos.forYouAllVideoList[index];
            return Stack(
              children: [
                CustomVideoPlayer(
                  videoFile: data.videoUrl.toString(),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
