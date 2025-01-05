import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final _contentController = TextEditingController();
  final _tagController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

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
            icon: const Icon(
              Icons.arrow_back,
              size: 40,
            )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.network(
              'https://picsum.photos/400',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                    child: TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: '문구 추가...'),
                      keyboardType: TextInputType.multiline, // 다중 줄 입력 지원
                      maxLines: null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 5),
                      child: TextField(
                        controller: _tagController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: '태그 추가...'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Button Pressed!');
                      print(_contentController.text);
                      print(_tagController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // 배경 색상
                      shadowColor: Colors.black, // 그림자 색상
                      elevation: 5, // 그림자 높이
                      shape: RoundedRectangleBorder(
                        // 버튼 모양
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 13),
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
                ),
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
