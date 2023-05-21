import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/authentication/login_screen.dart';
import 'package:tiktok_clone/home/home_screen.dart';
import 'user.dart' as userModel;

class AuthenticationController extends GetxController {
  static AuthenticationController instanceAuth = Get.find();

  late Rx<User?> _currentUser;

  Rx<File?> _pickFile = Rx<File?>(null);
  // late Rx<File?> _pickFile;
  Rx<bool> progressBar = Rx<bool>(false);

  bool get showProgressBar => progressBar.value;

  File? get profileImage => _pickFile.value;

  void enablePB() {
    progressBar.value = !progressBar.value;
    // progressBar.refresh();
  }

  void chooseImageFromGalery() async {
    final pickImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickImageFile != null) {
      Get.snackbar(
        "Profile Image",
        "You have successfully selected your profile image",
      );
      _pickFile.value = File(pickImageFile.path);
      // _pickFile = Rx<File?>(
      //   File(pickImageFile.path),
      // );
    }
    print("data : ${profileImage?.path}");
  }

  void captureImageWithCamera() async {
    final pickImageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickImageFile != null) {
      Get.snackbar(
        "Profile Image",
        "You have successfully capture your profile image",
      );
    }

    _pickFile = Rx<File?>(
      File(pickImageFile!.path),
    );
  }

  void createAccount({
    required String username,
    required String email,
    required String password,
    required File imageFile,
  }) async {
    try {
      //create user
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //upload Image
      String imageDownloadUrl = await uploadImageToStorage(
        imageFile: imageFile,
      );

      //save to DB
      userModel.User user = userModel.User(
        uid: credential.user!.uid,
        name: username,
        email: email,
        image: imageDownloadUrl,
      );
      await FirebaseFirestore.instance
          .collection(
            "users",
          )
          .doc(
            credential.user!.uid,
          )
          .set(user.toJson());
      Get.snackbar(
        "Account Created",
        "Success register your account",
      );
      enablePB();
      Get.off(const LoginScreen());
    } catch (e) {
      Get.snackbar(
        "Account Creation Unsuccessful",
        e.toString(),
      );
      enablePB();
      Get.off(const LoginScreen());
    }
  }

  Future<String> uploadImageToStorage({
    required File imageFile,
  }) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child(
          "Profile Images",
        )
        .child(
          FirebaseAuth.instance.currentUser!.uid,
        );
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  void login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(credential.user!.email);
      print(credential.user!.uid);
      Get.snackbar(
        "Login",
        "Success login to your account",
      );
      enablePB();
    } catch (e) {
      Get.snackbar(
        "Login Unsuccessful",
        e.toString(),
      );
      enablePB();
    }
  }

  goToScreen(User? currentUser) {
    //user not login
    if (currentUser == null) {
      Get.offAll(const LoginScreen());
    } else {
      Get.offAll(const HomeScreen());
    }
  }

  @override
  void onReady() {
    print("onReady auth state ");
    _currentUser = Rx<User?>(
      FirebaseAuth.instance.currentUser,
    );
    _currentUser.bindStream(
      FirebaseAuth.instance.authStateChanges(),
    );
    ever(_currentUser, goToScreen);
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    print("onClose auth state ");
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {
    print("dispose auth state ");
    // TODO: implement dispose
    super.dispose();
  }
}
