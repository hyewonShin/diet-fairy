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

  final List<String> _tags = []; // 태그를 저장하는 리스트

  @override
  void setState(VoidCallback fn) {
    isError = widget.tagController.text.isNotEmpty;
    super.setState(fn);
  }

  void createTag(value) {
    if (value.isNotEmpty && !value.startsWith('#')) {
      // 사용자 입력이 '#'으로 시작하지 않으면 추가
      widget.tagController.value = TextEditingValue(
        text: '#$value',
        selection: TextSelection.fromPosition(
          TextPosition(offset: value.length + 1), // 커서를 올바른 위치로 이동
        ),
      );
    }
  }

  void _addTag(String value) {
    if (value.isNotEmpty) {
      setState(() {
        _tags.add(value); // 태그 리스트에 추가
      });
      widget.tagController.clear(); // 텍스트 필드 초기화
    }
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
                setState(() {
                  if (value.trim().isEmpty) {
                    isError = true;
                    errorText = '태그 내용을 입력해주세요.';
                  } else {
                    isError = false;
                    errorText = null;
                  }
                });
                createTag(value);
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
