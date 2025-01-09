import 'package:diet_fairy/domain/entity/user.dart';

abstract interface class UserRepository {
  Future<void> createUser(String userId, String nickname);

  Future<User?> getUser(String userId);
}
