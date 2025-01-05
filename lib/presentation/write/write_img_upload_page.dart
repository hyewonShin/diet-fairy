import 'package:diet_fairy/presentation/write/write_page.dart';
import 'package:flutter/material.dart';

class WriteImgUploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  builder: (context) => WritePage(),
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
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Image.network(
              'https://picsum.photos/400',
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
