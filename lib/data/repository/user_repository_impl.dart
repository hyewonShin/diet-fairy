import 'package:diet_fairy/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> createUser(String userId, String nickname) {
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  //
}
