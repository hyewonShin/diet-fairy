import 'package:diet_fairy/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diet_fairy/domain/entity/user.dart' as u;

class LoginUsecase {
  LoginUsecase(this._userRepository);
  final UserRepository _userRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<LoginResult> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // 인증 성공
        final u.User? user =
            await _userRepository.getUser(credential.user!.uid);

        if (user != null) {
          return LoginResult(null, user);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        return LoginResult(
          '해당 계정은 비활성화되었습니다.',
          null,
        );
      } else if (e.code == 'user-not-found') {
        return LoginResult(
          '해당 이메일로 가입된 계정이 없습니다.',
          null,
        );
      } else if (e.code == 'wrong-password') {
        return LoginResult(
          '비밀번호가 잘못되었습니다.',
          null,
        );
      } else if (e.code == 'too-many-requests') {
        return LoginResult(
          '잠시 후에 다시 사용해주세요.',
          null,
        );
      } else if (e.code == 'user-token-expired') {
        return LoginResult(
          '계정 인증이 만료되었습니다.',
          null,
        );
      } else if (e.code == 'network-request-failed') {
        return LoginResult(
          '네트워크가 불안정합니다. 다시 시도해주세요.',
          null,
        );
      } else if (e.code == 'invalid-credential') {
        return LoginResult(
          '유효하지 않은 계정입니다.',
          null,
        );
      } else if (e.code == 'operation-not-allowed') {
        return LoginResult(
          '비활성화된 계정입니다.',
          null,
        );
      }
    }
    return LoginResult(
      '로그인에 실패하였습니다.',
      null,
    );
  }
}

/// 로그인 usecase 에서 반환할 데이터 처리를 위한 클래스
class LoginResult {
  /// 다이얼로그에 찍어줄 로그인 실패 이유(예시: 비밀번호가 잘못되었습니다.)
  /// 성공시 null
  String? failResult;

  /// 로그인 성공 후 가져온 User 데이터
  u.User? user;

  LoginResult(this.failResult, this.user);
}
