import 'package:flutter/material.dart';

class TagBox extends StatefulWidget {
  final TextEditingController tagController;
  final Function(List<String>) onTagChanged;

  const TagBox({
    required this.tagController,
    required this.onTagChanged,
    super.key,
  });

  @override
  State<TagBox> createState() => _ContentsBoxState();
}

class _ContentsBoxState extends State<TagBox> {
  bool isError = false;

  final List<String> _tags = []; // 태그를 저장하는 리스트

  void createTag(String value) {
    if (value.trim().isNotEmpty && !_tags.contains(value.trim())) {
      setState(() {
        _tags.add(value.trim().replaceAll('#', ''));
        widget.tagController.clear();
      });
      widget.onTagChanged(_tags); // 태그가 변경될 때 부모에게 알림
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 태그 표시 부분
        _tags.isNotEmpty
            ? SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _tags.map((tag) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(tag,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _tags.remove(tag); // 태그 삭제
                                });
                              },
                              child: const Icon(Icons.close,
                                  size: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: isError
                ? Border.all(color: Colors.red[200]!, width: 2)
                : Border.all(color: Colors.transparent, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: TextFormField(
              controller: widget.tagController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '# 태그 추가...',
              ),
              onChanged: (value) {
                if (value.isNotEmpty && !value.startsWith('#')) {
                  // 사용자 입력이 '#'으로 시작하지 않으면 추가
                  widget.tagController.value = TextEditingValue(
                    text: '#$value',
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: value.length + 1), // 커서를 올바른 위치로 이동
                    ),
                  );
                }
                setState(() {
                  isError = value.trim().isEmpty;
                });
                // 스페이스 입력 시 태그 추가
                if (value.endsWith(' ')) {
                  createTag(value.trim());
                }
              },
              validator: (value) {
                if (_tags.isEmpty) {
                  setState(() {
                    isError = true;
                  });
                  return '태그를 입력하고 스페이스바를 눌러주세요.';
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
