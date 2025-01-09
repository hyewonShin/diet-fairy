import 'package:flutter/material.dart';

class ContentsBox extends StatefulWidget {
  final TextEditingController contentController;
  final double screenHeight;

  const ContentsBox(
      {required this.contentController, required this.screenHeight, super.key});

  @override
  State<ContentsBox> createState() => _ContentsBoxState();
}

class _ContentsBoxState extends State<ContentsBox> {
  String? text;

  @override
  Widget build(BuildContext context) {
    print(widget.screenHeight);
    print(widget.screenHeight.runtimeType);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.screenHeight / 4,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              border: text != null
                  ? Border.all(color: Colors.red[200]!, width: 2)
                  : null),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            child: TextFormField(
              controller: widget.contentController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '문구 추가...',
              ),
              keyboardType: TextInputType.multiline, // 다중 줄 입력 지원
              maxLines: null,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  setState(() {
                    text = '본문 내용을 입력해주세요.';
                  });
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
