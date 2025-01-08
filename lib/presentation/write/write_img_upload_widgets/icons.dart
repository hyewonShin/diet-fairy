import 'package:flutter/material.dart';

Widget icon({bool camera = false}) {
  return Container(
      padding: const EdgeInsets.all(3.0),
      margin: const EdgeInsets.all(4.0),
      decoration:
          const BoxDecoration(color: Color(0xff808080), shape: BoxShape.circle),
      child: Icon(
        camera ? Icons.image_search : Icons.camera_alt,
        size: 30,
      ));
}
