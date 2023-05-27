import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/home/upload_video/video.dart';

class ControllerForYouVideo extends GetxController {
  final Rx<List<Video>> forYouVideoList = Rx<List<Video>>([]);

  List<Video> get forYouAllVideoList => forYouVideoList.value;

  @override
  void onInit() {
    forYouVideoList.bindStream(
      FirebaseFirestore.instance
          .collection("videos")
          .orderBy("totalComments", descending: true)
          .snapshots()
          .map(
        (QuerySnapshot snapshotQuery) {
          List<Video> videoList = [];
          for (var eachVideo in snapshotQuery.docs) {
            videoList.add(
              Video.fromDocumentSnapshot(eachVideo),
            );
          }
          return videoList;
        },
      ),
    );
    super.onInit();
  }
}
