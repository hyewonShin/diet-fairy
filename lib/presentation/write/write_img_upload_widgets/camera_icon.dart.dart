import 'package:flutter/material.dart';

Widget cameraIcon() {
  return Container(
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 215, 212, 212),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.camera_alt,
        size: 25,
      ));
}
