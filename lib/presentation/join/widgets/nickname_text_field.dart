import 'package:flutter/material.dart';

class NicknameTextField extends StatelessWidget {
  NicknameTextField(this.nicknameController);
  TextEditingController nicknameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nicknameController,
      decoration: const InputDecoration(
        hintText: '닉네임을 입력해주세요',
      ),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return '닉네임을 한 글자 이상 입력해주세요.';
        }
        // 유효성 검사 통과
        return null;
      },
    );
  }
}
