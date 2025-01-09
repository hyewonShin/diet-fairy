import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/data/data_source/firebase_user_data_source.dart';
import 'package:diet_fairy/data/repository/user_repository_impl.dart';
import 'package:diet_fairy/domain/repository/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(FirebaseUserDataSource());
});
