import 'package:diet_fairy/presentation/home/home_page.dart';
import 'package:diet_fairy/presentation/widgets/id_text_field.dart';
import 'package:diet_fairy/presentation/widgets/pw_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                            // HomePage 로 넘어갈 때 이전 stack 에 쌓인 모든 페이지 지움
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.blue,
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
