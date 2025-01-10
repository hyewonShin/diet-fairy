import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/data_source/feed_data_source.dart';
import 'package:diet_fairy/data/data_source/feed_data_source_impl.dart';
import 'package:diet_fairy/data/data_source/user_data_source.dart';
import 'package:diet_fairy/data/data_source/user_data_source_impl.dart';
import 'package:diet_fairy/data/repository/feed_repository_impl.dart';
import 'package:diet_fairy/data/repository/user_repository_impl.dart';
import 'package:diet_fairy/domain/repository/feed_repository.dart';
import 'package:diet_fairy/domain/repository/user_repository.dart';
import 'package:diet_fairy/domain/usecase/add_feed_use_case.dart';
import 'package:diet_fairy/domain/usecase/fetch_feed_usecase.dart';
import 'package:diet_fairy/domain/usecase/fetch_more_feed_usecase.dart';
import 'package:diet_fairy/domain/usecase/join_usecase.dart';
import 'package:diet_fairy/domain/usecase/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _firebase = FirebaseFirestore.instance;

final _userDataSourceProvider = Provider<UserDataSource>(
  (ref) {
    return UserDataSourceImpl(_firebase);
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

final _feedDataSourceProvider = Provider<FeedDataSource>(
  (ref) {
    return FeedDataSourceImpl(_firebase);
  },
);

final _feedRespositoryProvider = Provider<FeedRepository>(
  (ref) {
    final feedDataSource = ref.read(_feedDataSourceProvider);
    return FeedRepositoryImpl(feedDataSource);
  },
);

final fetchFeedUsecaseProvider = Provider<FetchFeedUsecase>(
  (ref) {
    final feedRepo = ref.read(_feedRespositoryProvider);
    return FetchFeedUsecase(feedRepo);
  },
);

final fetchMoreFeedUsecaseProvider = Provider<FetchMoreFeedUsecase>(
  (ref) {
    final feedRepo = ref.read(_feedRespositoryProvider);
    return FetchMoreFeedUsecase(feedRepo);
  },
);

final addFeedUsecaseProvider = Provider<AddFeedUseCase>(
  (ref) {
    final feedRepo = ref.read(_feedRespositoryProvider);
    return AddFeedUseCase(feedRepo);
  },
);
