import 'package:diet_fairy/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JoinUsecase {
  JoinUsecase(this._userRepository);
  final UserRepository _userRepository;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> join({
    required String email,
    required String nickname,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final uid = credential.user!.uid;
        await _userRepository.createUser(uid, nickname);
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return '이미 사용하고 있는 이메일입니다.';
      } else if (e.code == 'invalid-email') {
        return '유효하지 않은 이메일입니다.';
      } else if (e.code == 'operation-not-allowed') {
        return '비활성화된 계정입니다.';
      } else if (e.code == 'weak-password') {
        return '비밀번호를 6글자 이상 작성해주세요.';
      } else if (e.code == 'too-many-requests') {
        return '잠시 후에 다시 사용해주세요.';
      } else if (e.code == 'network-request-failed') {
        return '네트워크가 불안정합니다. 다시 시도해주세요.';
      }
      return '회원가입에 실패했습니다.';
    }
  }
}
