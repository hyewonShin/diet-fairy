import 'package:diet_fairy/presentation/write/write_page.dart';
import 'package:flutter/material.dart';

class WriteImgUploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "새 게시물",
          ),
        ),
        leading: IconButton(
            onPressed: () {},
            //TODO 아이콘에 가로세로 50 씩 크기 주기
            icon: Icon(
              Icons.close,
              size: 40,
            )),
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
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
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
