import 'package:flutter/material.dart';
import 'package:diet_fairy/presentation/write/write_page.dart';

AppBar writePageAppbar({
  required BuildContext context,
  required bool appBarFlag,
  bool multiImageFlag = false,
  selectedImage,
  selectedImages,
}) {
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
      icon: Icon(
        appBarFlag ? Icons.close : Icons.arrow_back,
        size: 40, // 아이콘 크기
      ),
      constraints: const BoxConstraints(
        minWidth: 50, // 가로 크기
        minHeight: 50, // 세로 크기
      ),
    ),
    actions: [
      if (appBarFlag)
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WritePage(
                    multiImageFlag: multiImageFlag,
                    selectedImage: selectedImage,
                    selectedImages: selectedImages),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: Text(
              "다음",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
    ],
  );
}
