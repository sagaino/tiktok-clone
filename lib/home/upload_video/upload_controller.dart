import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/global.dart';
import 'package:tiktok_clone/home/home_screen.dart';
import 'package:tiktok_clone/home/upload_video/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadController extends GetxController {
  Future compressVideoFile(String videoFilePath) async {
    final compressVideoFile = await VideoCompress.compressVideo(
      videoFilePath,
      quality: VideoQuality.HighestQuality,
    );
    return compressVideoFile!.file;
  }

  Future getThumbnailImage(String videpFilePath) async {
    final thumbnailImage = await VideoCompress.getFileThumbnail(videpFilePath);
    return thumbnailImage;
  }

  Future uploadVideo(String videoID, String videoFilePath) async {
    UploadTask videoUploadTask = FirebaseStorage.instance
        .ref()
        .child("All Videos")
        .child(videoID)
        .putFile(
          await compressVideoFile(
            videoFilePath,
          ),
        );
    TaskSnapshot snapshot = await videoUploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future uploadVideoThumbnail(String videoID, String videoFilePath) async {
    UploadTask thumbnailUploadTask = FirebaseStorage.instance
        .ref()
        .child("All Thumbnails")
        .child(videoID)
        .putFile(
          await getThumbnailImage(
            videoFilePath,
          ),
        );
    TaskSnapshot snapshot = await thumbnailUploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future saveInformation(
    String artisSongName,
    String description,
    String videoFilePath,
    BuildContext context,
  ) async {
    try {
      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      String videoID = DateTime.now().millisecondsSinceEpoch.toString();
      final videoDownloadUrl = await uploadVideo(videoID, videoFilePath);
      final thumbnailDownloadUrl =
          await uploadVideoThumbnail(videoID, videoFilePath);

      Video videoObject = Video(
        userID: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDocumentSnapshot.data() as Map<String, dynamic>)['name'],
        userProfileImage:
            (userDocumentSnapshot.data() as Map<String, dynamic>)['image'],
        videoID: videoID,
        totalComments: 0,
        totalShares: 0,
        likesList: [],
        artisSongName: artisSongName,
        descriptionTags: description,
        videoUrl: videoDownloadUrl,
        thumbnailUrl: thumbnailDownloadUrl,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );

      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoID)
          .set(videoObject.toJson());
      showProgressBar = false;
      Get.offAll(const HomeScreen());
      Get.snackbar("New Video", "Your new video successfuly uploaded");
    } catch (e) {
      Get.snackbar("Upload Failed", "Upload Failed, please try again");
    }
  }
}
