import 'package:flutter/material.dart';

Widget photoLibraryIcon({required multiImageFlag}) {
  return Container(
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: multiImageFlag
            ? Color.fromARGB(255, 84, 166, 255)
            : Color.fromARGB(255, 215, 212, 212),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.photo_library,
        size: 25,
        color: multiImageFlag ? Colors.white : Colors.black,
      ));
}
