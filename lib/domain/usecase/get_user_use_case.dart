import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/domain/repository/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<User?> execute(String userId) {
    return repository.getUser(userId);
  }
}
