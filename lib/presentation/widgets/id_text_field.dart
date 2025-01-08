import 'package:flutter/material.dart';

class IdTextField extends StatelessWidget {
  IdTextField(this.idController);
  TextEditingController idController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: idController,
      decoration: const InputDecoration(
        hintText: '이메일을 입력해주세요',
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
