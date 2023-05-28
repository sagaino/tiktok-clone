import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/home/for_you/controller_for_you_video.dart';
import 'package:tiktok_clone/widgets/circula_image_animation.dart';
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
          physics: const CustomPageViewScrollPhysics(),
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
                Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 22,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "@${data.userName}",
                                    style: GoogleFonts.abel(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "${data.descriptionTags}",
                                    style: GoogleFonts.abel(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "images/music_note.png",
                                        width: 20,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: Text(
                                          data.artisSongName.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.abel(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //rigth side
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 4,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: SizedBox(
                                    width: 62,
                                    height: 62,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 6,
                                          child: Container(
                                            width: 52,
                                            height: 52,
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image(
                                                image: NetworkImage(
                                                  data.userProfileImage
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controllerVideos.likeOrUnLikeVideo(
                                          data.videoID.toString(),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.favorite_rounded,
                                        size: 40,
                                        color: data.likesList!.contains(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                        )
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        data.likesList!.length.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add_comment,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        data.totalComments.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        data.totalShares.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: CircularImageAnimation(
                                    widgetAnimation: SizedBox(
                                      width: 62,
                                      height: 62,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            height: 52,
                                            width: 52,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.grey,
                                                  Colors.white,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: ClipRRect(
                                              child: Image(
                                                image: NetworkImage(
                                                  data.userProfileImage
                                                      .toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 1,
      );
}
