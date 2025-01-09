import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/data/repository/user_repository_provider.dart';
import 'package:diet_fairy/domain/usecase/get_user_use_case.dart';

final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserUseCase(repository);
});
