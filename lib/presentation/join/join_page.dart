import 'package:diet_fairy/presentation/join/widgets/nickname_text_field.dart';
import 'package:diet_fairy/presentation/login/login_page.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:diet_fairy/presentation/widgets/id_text_field.dart';
import 'package:diet_fairy/presentation/widgets/pw_text_field.dart';
import 'package:diet_fairy/util/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends ConsumerState<JoinPage> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final nicknameController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    nicknameController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const Text('환영합니다!', style: TextStyle(fontSize: 25)),
                  const SizedBox(height: 20),

                  // 아이디
                  const Text('아이디'),
                  const SizedBox(height: 3),
                  IdTextField(idController),
                  const SizedBox(height: 20),

                  // 닉네임
                  const Text('닉네임'),
                  const SizedBox(height: 3),
                  NicknameTextField(nicknameController),
                  const SizedBox(height: 20),

                  // 비밀번호
                  const Text('비밀번호'),
                  const SizedBox(height: 3),
                  PwTextField(pwController),
                  const SizedBox(height: 50),

                  // 회원가입 버튼
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final vm =
                              ref.read(userGlobalViewModelProvider.notifier);

                          final result = await vm.join(
                            email: idController.text,
                            nickname: nicknameController.text,
                            password: pwController.text,
                          );
                          // 회원가입 실패
                          if (result != null) {
                            await customCupertinoDialog(
                              context: context,
                              title: null,
                              content: result,
                            );
                          } else {
                            // 회원가입 성공
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
