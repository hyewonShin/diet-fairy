import 'package:flutter/material.dart';

// TODO 아이콘에 가로세로 50씩 공간 주기
Widget icon({bool camera = false}) {
  return Container(
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 215, 212, 212), shape: BoxShape.circle),
      child: Icon(
        camera ? Icons.photo_library : Icons.camera_alt,
        size: 25,
      ));
}
