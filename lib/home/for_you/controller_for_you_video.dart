import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          print("data 1233 : $videoList");

          return videoList;
        },
      ),
    );
    super.onInit();
  }

  // Future likeOrUnLikeVideo(String videoID) async {
  //   var currentUserID = FirebaseAuth.instance.currentUser!.uid;

  //   DocumentSnapshot snapshotDoc = await FirebaseFirestore.instance
  //       .collection("videos")
  //       .doc(videoID)
  //       .get();

  //   var likesList = (snapshotDoc.data() as dynamic)["likesList"];
  //   // var likeCount = (snapshotDoc.data() as dynamic)["likeCount"] ?? 0;

  //   if (likesList.contains(currentUserID)) {
  //     // User already liked the video
  //     await FirebaseFirestore.instance
  //         .collection("videos")
  //         .doc(videoID)
  //         .update({
  //       "likesList": FieldValue.arrayRemove([currentUserID]),
  //       // "likeCount": likeCount - 1,
  //     });

  //     // forYouVideoList.bindStream(
  //     //   FirebaseFirestore.instance
  //     //       .collection("videos")
  //     //       .orderBy("totalComments", descending: true)
  //     //       .snapshots()
  //     //       .map(
  //     //     (QuerySnapshot snapshotQuery) {
  //     //       List<Video> videoList = [];
  //     //       for (var eachVideo in snapshotQuery.docs) {
  //     //         videoList.add(
  //     //           Video.fromDocumentSnapshot(eachVideo),
  //     //         );
  //     //       }
  //     //       print("data 1233 : $videoList");

  //     //       return videoList;
  //     //     },
  //     //   ),
  //     // );
  //   } else {
  //     // User not liked the video
  //     await FirebaseFirestore.instance
  //         .collection("videos")
  //         .doc(videoID)
  //         .update({
  //       "likesList": FieldValue.arrayUnion([currentUserID]),
  //       // "likeCount": likeCount + 1,
  //     });
  //   }
  // }
  Future<void> likeOrUnLikeVideo(String videoID) async {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid;

    // Create a reference to the Firestore document
    DocumentReference videoRef =
        FirebaseFirestore.instance.collection("videos").doc(videoID);

    // Run the transaction
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(videoRef);
      List<String> likesList = List.from(snapshot["likesList"]);

      if (likesList.contains(currentUserID)) {
        // User already liked the video
        likesList.remove(currentUserID);
      } else {
        // User not liked the video
        likesList.add(currentUserID);
      }

      // Update the likesList field in the Firestore document
      transaction.update(videoRef, {"likesList": likesList});
    });
  }
}
