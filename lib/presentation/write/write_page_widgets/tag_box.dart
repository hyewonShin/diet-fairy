import 'package:flutter/material.dart';

Widget tagBox(tagController) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        child: TextField(
          controller: tagController,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: '태그 추가...'),
        ),
      ),
    ),
  );
}
