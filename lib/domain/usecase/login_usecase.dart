import 'package:firebase_auth/firebase_auth.dart';

class LoginUsecase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    print('email => $email, password => $password');
    try {
      UserCredential _credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_credential.user != null) {
        print('login 성공');
      } else {
        print('login 실패');
      }
    } on FirebaseAuthException catch (e) {
      print('login 실패 e => $e');
      print('e.code => ${e.code}');
    } catch (allE) {
      //
    }
  }
}
