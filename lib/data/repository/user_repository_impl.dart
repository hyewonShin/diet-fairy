import 'package:diet_fairy/data/data_source/user_data_source.dart';
import 'package:diet_fairy/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userDataSource);

  final UserDataSource _userDataSource;

  @override
  Future<void> createUser(String userId, String nickname) async {
    await _userDataSource.createUser(userId, nickname);
  }

  @override
  Future<User> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  //
}
