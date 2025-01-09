import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/data/repository/comment_repository_provider.dart';
import 'package:diet_fairy/domain/use_case/add_comment_use_case.dart';
import 'package:diet_fairy/domain/use_case/get_comments_use_case.dart';

final getCommentsUseCaseProvider = Provider<GetCommentsUseCase>((ref) {
  final repository = ref.watch(commentRepositoryProvider);
  return GetCommentsUseCase(repository);
});

final addCommentUseCaseProvider = Provider<AddCommentUseCase>((ref) {
  final repository = ref.watch(commentRepositoryProvider);
  return AddCommentUseCase(repository);
});
