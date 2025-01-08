// TODO 아이콘에 가로세로 50씩 공간 주기
import 'package:flutter/material.dart';

Widget photoLibraryIcon({required multiImageFlag}) {
  return Container(
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: multiImageFlag
            ? Color.fromARGB(255, 174, 168, 168)
            : Color.fromARGB(255, 215, 212, 212),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.photo_library,
        size: 25,
      ));
}
