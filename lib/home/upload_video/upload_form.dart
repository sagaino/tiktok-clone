import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone/global.dart';
import 'package:tiktok_clone/home/upload_video/upload_controller.dart';
import 'package:tiktok_clone/widgets/input_text_widget.dart';
import 'package:video_player/video_player.dart';

class UploadForm extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const UploadForm({
    super.key,
    required this.videoFile,
    required this.videoPath,
  });

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  UploadController uploadVideoController = Get.put(UploadController());

  VideoPlayerController? playerController;
  TextEditingController artistSongTextEditingController =
      TextEditingController();
  TextEditingController descriptionTagsTextEditingController =
      TextEditingController();
  @override
  void initState() {
    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);
    });
    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    playerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: VideoPlayer(
                playerController!,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            showProgressBar == true
                ? const SimpleCircularProgressBar(
                    progressColors: [
                      Colors.green,
                      Colors.blueAccent,
                      Colors.red,
                      Colors.amber,
                      Colors.purpleAccent,
                    ],
                    animationDuration: 20,
                    backColor: Colors.white38,
                  )
                : Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: InputTextWidget(
                          controller: artistSongTextEditingController,
                          labelString: "Artist Song",
                          iconData: Icons.music_video_sharp,
                          isObsecure: false,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: InputTextWidget(
                          controller: descriptionTagsTextEditingController,
                          labelString: "Description Text",
                          iconData: Icons.slideshow_sharp,
                          isObsecure: false,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 38,
                        height: 54,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (artistSongTextEditingController
                                    .text.isNotEmpty &&
                                descriptionTagsTextEditingController
                                    .text.isNotEmpty) {
                              uploadVideoController.saveInformation(
                                artistSongTextEditingController.text,
                                descriptionTagsTextEditingController.text,
                                widget.videoPath,
                                context,
                              );
                            }
                            setState(() {
                              showProgressBar = true;
                            });
                          },
                          child: const Center(
                            child: Text(
                              "Upload Now",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
