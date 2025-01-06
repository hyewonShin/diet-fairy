import 'package:flutter/material.dart';

class PwTextField extends StatelessWidget {
  PwTextField(this.pwController);
  TextEditingController pwController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: pwController,
      // 비밀번호 숨김
      obscureText: true,
      decoration: InputDecoration(
        hintText: '비밀번호를 입력해주세요',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return '비밀번호를 한 글자 이상 입력해주세요.';
        }
        // 유효성 검사 통과
        return null;
      },
    );
  }
}
