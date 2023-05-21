import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone/authentication/authentication_controller.dart';
import 'package:tiktok_clone/authentication/login_screen.dart';
import 'package:tiktok_clone/global.dart';
import 'package:tiktok_clone/widgets/input_text_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthenticationController controller =
      Get.put(AuthenticationController());
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  // bool showProgressBar = false;
  // var controller = AuthenticationController.instanceAuth;

  @override
  void dispose() {
    // Get.delete<AuthenticationController>();
    print("dispose regis screen");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Create Account",
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "to get Started now",
                style: GoogleFonts.actor(
                  fontSize: 34,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  controller.chooseImageFromGalery();
                  // controller.profileImage;
                },
                child: Obx(
                  () => CircleAvatar(
                    radius: 80,
                    backgroundImage: controller.profileImage != null
                        ? FileImage(controller.profileImage!)
                        : const AssetImage("images/profile_avatar.jpg")
                            as ImageProvider<Object>?,
                    // backgroundImage: AssetImage(
                    //   "images/profile_avatar.jpg",
                    // ),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: InputTextWidget(
                  controller: userNameTextEditingController,
                  labelString: "Username",
                  iconData: Icons.person,
                  isObsecure: false,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: InputTextWidget(
                  controller: emailTextEditingController,
                  labelString: "Email",
                  iconData: Icons.email_outlined,
                  isObsecure: false,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: InputTextWidget(
                  controller: passwordTextEditingController,
                  labelString: "Password",
                  iconData: Icons.lock_outline,
                  isObsecure: true,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(
                () => controller.showProgressBar == false
                    ? Column(
                        children: [
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
                                if (controller.profileImage == null ||
                                    userNameTextEditingController
                                        .text.isEmpty ||
                                    emailTextEditingController.text.isEmpty ||
                                    passwordTextEditingController
                                        .text.isEmpty) {
                                  return;
                                }
                                print("test");
                                controller.enablePB();
                                controller.createAccount(
                                  username: userNameTextEditingController.text,
                                  email: emailTextEditingController.text,
                                  password: passwordTextEditingController.text,
                                  imageFile: controller.profileImage!,
                                );
                                // showProgressBar = true;
                                // setState(() {});
                              },
                              child: const Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text(
                          //       "have an Account? ",
                          //       style: TextStyle(
                          //         fontSize: 16,
                          //         color: Colors.grey,
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       height: 50,
                          //     ),
                          //     InkWell(
                          //       onTap: () {
                          //         Get.off(
                          //           () => const LoginScreen(),
                          //         );
                          //       },
                          //       child: const Text(
                          //         "Login Now",
                          //         style: TextStyle(
                          //           fontSize: 18,
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      )
                    : const SimpleCircularProgressBar(
                        progressColors: [
                          Colors.green,
                          Colors.blueAccent,
                          Colors.red,
                          Colors.amber,
                          Colors.purpleAccent,
                        ],
                        animationDuration: 3,
                        backColor: Colors.white38,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "have an Account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      // Get.delete<AuthenticationController>();
                      Get.off(
                        () => const LoginScreen(),
                      );
                    },
                    child: const Text(
                      "Login Now",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
