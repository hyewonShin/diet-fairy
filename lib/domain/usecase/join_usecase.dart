import 'package:firebase_auth/firebase_auth.dart';

class JoinUsecase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> join(String email, String password) async {
    try {
      final UserCredential _credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_credential.user != null) {
        print('join 성공');
      } else {
        print('join 실패');
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return '이미 사용하고 있는 이메일입니다.';
      } else if (e.code == 'invalid-email') {
        return '유효하지 않은 이메일입니다.';
      } else if (e.code == 'operation-not-allowed') {}
      print('join 실패 e => $e');
      print('e.code => ${e.code}');
    }
  }
}
