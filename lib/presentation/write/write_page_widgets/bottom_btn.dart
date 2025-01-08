import 'package:flutter/material.dart';

Widget bottomBtn(
    {required context,
    required contentController,
    tagController,
    required double bottomPadding}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 20.0, // 좌측 여백
      right: 20.0, // 우측 여백
      bottom: bottomPadding, // 버튼을 하단에서 띄우는 여백
    ),
    child: ElevatedButton(
      onPressed: () {
        print('Button Pressed!');
        print(contentController.text);
        print(tagController.text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary, // 배경 색상
        shadowColor: Colors.black, // 그림자 색상
        elevation: 5, // 그림자 높이
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      child: const Text(
        '공유',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ), // 텍스트 스타일
      ),
    ),
  );
}
