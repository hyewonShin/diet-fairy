import 'package:diet_fairy/data/data_source/user_data_source.dart';
import 'package:diet_fairy/domain/repository/user_repository.dart';
import 'package:diet_fairy/domain/entity/user.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userDataSource);

  final UserDataSource _userDataSource;

  @override
  Future<void> createUser(String userId, String nickname) async {
    await _userDataSource.createUser(userId, nickname);
  }

  @override
  Future<User?> getUser(String userId) async {
    final userDto = await _userDataSource.getUser(userId);

    if (userDto != null) {
      return User(
        userId: userDto.userId,
        nickname: userDto.nickname,
        imageUrl: userDto.imageUrl,
        feedCreatedAt: userDto.feedCreatedAt,
        weight: userDto.weight,
        desiredWeight: userDto.desiredWeight,
        likeFeed: userDto.likeFeed?.map((e) => e.toString()).toList(),
      );
    } else {
      return null;
    }
  }
}
