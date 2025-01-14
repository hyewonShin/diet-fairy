import 'package:flutter/material.dart';

class PrivacyPolicyCheckBox extends StatefulWidget {
  PrivacyPolicyCheckBox(this.setChecked);
  Function setChecked;
  @override
  State<PrivacyPolicyCheckBox> createState() => _PrivacyPolicyCheckBoxState();
}

class _PrivacyPolicyCheckBoxState extends State<PrivacyPolicyCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 체크박스
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            isChecked = value!;
            widget.setChecked();
          },
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: const Text('회원가입 및 이용약관에 동의하시겠습니까'),
        ),
      ],
    );
  }
}
