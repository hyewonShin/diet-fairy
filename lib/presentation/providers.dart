import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/data_source/user_data_source.dart';
import 'package:diet_fairy/data/data_source/user_data_source_impl.dart';
import 'package:diet_fairy/data/repository/user_repository_impl.dart';
import 'package:diet_fairy/domain/repository/user_repository.dart';
import 'package:diet_fairy/domain/usecase/join_usecase.dart';
import 'package:diet_fairy/domain/usecase/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _userDataSourceProvider = Provider<UserDataSource>(
  (ref) {
    return UserDataSourceImpl(FirebaseFirestore.instance);
  },
);

final _userRepositoryProvider = Provider<UserRepository>(
  (ref) {
    final dataSource = ref.read(_userDataSourceProvider);
    return UserRepositoryImpl(dataSource);
  },
);

final joinUsecaseProvider = Provider<JoinUsecase>(
  (ref) {
    final userRepo = ref.read(_userRepositoryProvider);
    return JoinUsecase(userRepo);
  },
);

final loginUsecaseProvider = Provider<LoginUsecase>(
  (ref) {
    final userRepo = ref.read(_userRepositoryProvider);
    return LoginUsecase(userRepo);
  },
);
