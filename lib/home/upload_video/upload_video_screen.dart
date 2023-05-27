import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/home/upload_video/upload_form.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  getVideoFile(ImageSource source) async {
    final videoFile = await ImagePicker().pickVideo(source: source);

    if (videoFile != null) {
      Get.to(
        UploadForm(
          videoFile: File(videoFile.path),
          videoPath: videoFile.path,
        ),
      );
    }
  }

  displayDialogBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () {
                getVideoFile(
                  ImageSource.gallery,
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.image,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Get Video from Galery",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                 getVideoFile(
                  ImageSource.camera,
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.camera,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Make Video with camera",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Get.back();
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.cancel,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/upload.png",
              width: 260,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                displayDialogBox();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Upload new video",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
