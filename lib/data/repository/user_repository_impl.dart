import 'package:diet_fairy/data/data_source/firebase_user_data_source.dart';
import 'package:diet_fairy/data/dto/user_dto.dart';
import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseUserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<User?> getUser(String userId) async {
    final dto = await _dataSource.getUser(userId);
    return dto?.toEntity();
  }

  @override
  Future<void> updateUser(User user) async {
    await _dataSource.updateUser(UserDto.fromEntity(user));
  }

  @override
  Future<String> uploadProfileImage(String userId, String imagePath) async {
    return await _dataSource.uploadProfileImage(userId, imagePath);
  }

  @override
  Future<void> createUser(String userId, String nickname) async {
    final userDto = UserDto(
      userId: userId,
      nickname: nickname,
      imageUrl: null,
      feedCreatedAt: [],
      weight: 0,
      desiredWeight: 0,
      likeFeed: [],
    );
    await _dataSource.createUser(userDto);
  }
}
