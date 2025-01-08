import 'package:flutter/material.dart';

Widget contentsBox({required contentController, required double screenHeight}) {
  return Container(
    height: screenHeight / 4,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      child: TextField(
        controller: contentController,
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: '문구 추가...'),
        keyboardType: TextInputType.multiline, // 다중 줄 입력 지원
        maxLines: null,
      ),
    ),
  );
}
