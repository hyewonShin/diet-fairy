import 'package:diet_fairy/presentation/home/home_page.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:diet_fairy/presentation/widgets/id_text_field.dart';
import 'package:diet_fairy/presentation/widgets/pw_text_field.dart';
import 'package:diet_fairy/util/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final pwController = TextEditingController();

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
                  const Text('로그인 해주세요', style: TextStyle(fontSize: 25)),
                  const SizedBox(height: 20),

                  // 아이디
                  const Text('아이디'),
                  const SizedBox(height: 3),
                  IdTextField(idController),
                  const SizedBox(height: 20),

                  // 비밀번호
                  const Text('비밀번호'),
                  const SizedBox(height: 3),
                  PwTextField(pwController),
                  const SizedBox(height: 50),

                  // 로그인 버튼
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final vm =
                              ref.read(userGlobalViewModelProvider.notifier);
                          final result = await vm.login(
                            email: idController.text,
                            password: pwController.text,
                          );

                          // 로그인 성공
                          if (result == null) {
                            final user =
                                ref.watch(userGlobalViewModelProvider)!;
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage(user);
                                },
                              ),
                              // HomePage 로 넘어갈 때 이전 stack 에 쌓인 모든 페이지 지움
                              (route) => false,
                            );
                          } else {
                            await customCupertinoDialog(
                              context: context,
                              title: null,
                              content: result,
                            );
                          }
                        }
                      },
                      child: const Text(
                        '로그인',
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
