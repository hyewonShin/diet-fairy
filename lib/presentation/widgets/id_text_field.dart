import 'package:flutter/material.dart';

class IdTextField extends StatelessWidget {
  IdTextField(this.idController);
  TextEditingController idController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: idController,
      decoration: InputDecoration(
        hintText: '아이디를 입력해주세요',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return '아이디를 한 글자 이상 입력해주세요.';
        }
        // 유효성 검사 통과
        return null;
      },
    );
  }
}
