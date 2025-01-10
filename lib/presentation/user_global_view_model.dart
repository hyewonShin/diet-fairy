import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserGlobalViewModel extends Notifier<User?> {
  @override
  User? build() {
    return null;
  }

  Future<String?> join({
    required String email,
    required String nickname,
    required String password,
  }) async {
    final joinUsecase = ref.read(joinUsecaseProvider);
    final result = await joinUsecase.join(
      email: email,
      nickname: nickname,
      password: password,
    );
    return result;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final loginUsecase = ref.read(loginUsecaseProvider);
    final result = await loginUsecase.login(email, password);

    // 로그인 성공
    if (result.failResult == null) {
      state = result.user!;
    }

    return result.failResult;
  }

  void updateUser(User user) {
    state = user;
  }
}

final userGlobalViewModelProvider =
    NotifierProvider<UserGlobalViewModel, User?>(
  () {
    return UserGlobalViewModel();
  },
);
