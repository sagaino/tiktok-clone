import 'package:flutter/material.dart';

class ForYourVideoScreen extends StatefulWidget {
  const ForYourVideoScreen({super.key});

  @override
  State<ForYourVideoScreen> createState() => _ForYourVideoScreenState();
}

class _ForYourVideoScreenState extends State<ForYourVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "For your video screen",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
