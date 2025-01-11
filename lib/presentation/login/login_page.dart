import 'package:diet_fairy/presentation/home/home_page.dart';
import 'package:diet_fairy/presentation/join/join_page.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:diet_fairy/presentation/widgets/id_text_field.dart';
import 'package:diet_fairy/presentation/widgets/pw_text_field.dart';
import 'package:diet_fairy/util/appbar.dart';
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
        appBar: showLogoAppbar(),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  const Text('다이어트 요정님 어서오세요', style: TextStyle(fontSize: 25)),
                  const SizedBox(height: 10),
                  const Text('로그인하고 다른 요정들의\n다이어트 팁을 놓치지 마세요!',
                      style: TextStyle(fontSize: 20)),
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
                  const SizedBox(height: 30),

                  // 회원가입 페이지 이동 버튼
                  _moveToJoin(context),
                  const SizedBox(height: 2),

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

  TextButton _moveToJoin(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return JoinPage();
          },
        ));
      },
      child: const Text(
        '아직 요정이 아니시라면 서둘러 회원가입을 해주세요!',
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
