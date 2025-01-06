import 'package:flutter/material.dart';
import 'package:diet_fairy/presentation/write/write_page.dart';

AppBar writePageAppbar(bool writePage, BuildContext context) {
  return AppBar(
    title: const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "새 게시물",
      ),
    ),
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 40,
        )),
  );
}

AppBar imgUploadAppbar(BuildContext context) {
  return AppBar(
    title: const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "새 게시물",
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      padding: const EdgeInsets.all(0), // 패딩 제거
      icon: const Icon(
        Icons.close,
        size: 40, // 아이콘 크기
      ),
      constraints: const BoxConstraints(
        minWidth: 50, // 가로 크기
        minHeight: 50, // 세로 크기
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WritePage(),
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 20, top: 10),
          child: Text(
            "다음",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF54A6FF)),
          ),
        ),
      ),
    ],
  );
}
