import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone/authentication/authentication_controller.dart';
import 'package:tiktok_clone/authentication/register_screen.dart';
import 'package:tiktok_clone/widgets/input_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final AuthenticationController controller = Get.find<AuthenticationController>();
  final AuthenticationController controller =
      Get.put(AuthenticationController());
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  // bool showProgressBar = false;

  @override
  void dispose() {
    super.dispose();
    // Get.delete<AuthenticationController>();
    print("dispose login screen");
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
              Image.asset(
                "images/tiktok.png",
                width: 200,
              ),
              Text(
                "Welcome",
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Glad to see you",
                style: GoogleFonts.actor(
                  fontSize: 34,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 50,
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
                                print("test");
                                if (emailTextEditingController.text.isEmpty ||
                                    passwordTextEditingController
                                        .text.isEmpty) {
                                  return;
                                }
                                controller.enablePB();
                                controller.login(
                                  email: emailTextEditingController.text,
                                  password: passwordTextEditingController.text,
                                );
                                // showProgressBar = true;
                                // setState(() {});
                              },
                              child: const Center(
                                child: Text(
                                  "Login",
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
                    "don't have an Account? ",
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
                      Get.delete<AuthenticationController>();
                      Get.off(
                        () => const RegisterScreen(),
                      );
                    },
                    child: const Text(
                      "Sign Up Now",
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
