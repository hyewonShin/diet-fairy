import 'package:flutter/material.dart';

class TagBox extends StatefulWidget {
  final TextEditingController tagController;

  const TagBox({required this.tagController, super.key});

  @override
  State<TagBox> createState() => _ContentsBoxState();
}

class _ContentsBoxState extends State<TagBox> {
  bool isError = false;
  String? errorText;

  @override
  void setState(VoidCallback fn) {
    isError = widget.tagController.text.isNotEmpty;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: isError
                  ? Border.all(color: Colors.red[200]!, width: 2)
                  : Border.all(color: Colors.transparent, width: 2)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: TextFormField(
              controller: widget.tagController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '태그 추가...',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (value) {
                // 텍스트가 변경될 때마다 상태를 업데이트하여 테두리 색상 변경
                setState(() {
                  if (value.trim().isEmpty) {
                    isError = true;
                    errorText = '태그 내용을 입력해주세요.';
                  } else {
                    isError = false;
                    errorText = null;
                  }
                });
              },
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  setState(() {
                    isError = true;
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
