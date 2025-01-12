import 'package:flutter/material.dart';

class TagBox extends StatefulWidget {
  final TextEditingController tagController;

  const TagBox({required this.tagController, super.key});

  @override
  State<TagBox> createState() => _ContentsBoxState();
}

class _ContentsBoxState extends State<TagBox> {
  bool isError = false;

  final List<String> _tags = []; // 태그를 저장하는 리스트

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
              maxLines: 1,
              onChanged: (value) {
                // 텍스트가 변경될 때마다 상태를 업데이트하여 테두리 색상 변경
                setState(() {
                  if (value.trim().isEmpty) {
                    isError = true;
                  } else {
                    isError = false;
                  }
                });
                createTag(value);
                // 텍스트에서 스페이스바가 눌렸을 때 이벤트 처리
                if (value.endsWith(' ')) {
                  _tags.add(value);
                  print(_tags);
                }
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  setState(() {
                    isError = true;
                  });
                  return ''; // 오류 메시지 숨김
                }
                return null; // 유효성 검사 통과
              },
            ),
          ),
        ),
      ],
    );
  }
}
