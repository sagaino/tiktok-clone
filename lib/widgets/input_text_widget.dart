import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData? iconData;
  final String? assetRefrence;
  final String labelString;
  final bool isObsecure;

  const InputTextWidget({
    super.key,
    required this.controller,
    this.iconData,
    this.assetRefrence,
    required this.labelString,
    required this.isObsecure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelString,
        prefixIcon: iconData != null
            ? Icon(iconData)
            : Padding(
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Image.asset(
                  assetRefrence!,
                  width: 10,
                ),
              ),
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      obscureText: isObsecure,
    );
  }
}
