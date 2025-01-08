import 'package:firebase_auth/firebase_auth.dart';

abstract interface class UserRepository {
  Future<void> createUser(String userId, String nickname);

  Future<User> getUser(String userId);
}
