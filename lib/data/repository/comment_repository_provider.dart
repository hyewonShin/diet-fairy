import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/data/data_source/firebase_comment_data_source.dart';
import 'package:diet_fairy/data/repository/comment_repository_impl.dart';
import 'package:diet_fairy/domain/repository/comment_repository.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  final dataSource = FirebaseCommentDataSource(ref);
  return CommentRepositoryImpl(dataSource);
});
