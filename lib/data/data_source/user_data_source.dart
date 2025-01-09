import 'package:diet_fairy/data/dto/user_dto.dart';

abstract interface class UserDataSource {
  Future<void> createUser(String userId, String nickname);

  Future<UserDto?> getUser(String userId);
}
