import 'package:diet_fairy/domain/use_case/add_comment_use_case.dart';
import 'package:diet_fairy/domain/use_case/get_comments_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/domain/model/comment.dart';
import 'package:diet_fairy/domain/use_case/comment_use_cases_provider.dart';

class CommentState {
  final List<Comment> comments;
  final bool isLoading;

  CommentState({
    this.comments = const [],
    this.isLoading = false,
  });

  CommentState copyWith({
    List<Comment>? comments,
    bool? isLoading,
  }) {
    return CommentState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final commentViewModelProvider =
    StateNotifierProvider<CommentViewModel, CommentState>((ref) {
  return CommentViewModel(
    getCommentsUseCase: ref.watch(getCommentsUseCaseProvider),
    addCommentUseCase: ref.watch(addCommentUseCaseProvider),
  );
});

class CommentViewModel extends StateNotifier<CommentState> {
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;

  CommentViewModel({
    required this.getCommentsUseCase,
    required this.addCommentUseCase,
  }) : super(CommentState()) {
    getComments();
  }

  Future<void> getComments() async {
    state = state.copyWith(isLoading: true);
    try {
      final comments = await getCommentsUseCase.execute();
      state = state.copyWith(
        comments: comments,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> addComment(String content) async {
    try {
      await addCommentUseCase.execute(content);
      await getComments(); // 댓글 목록 새로고침
    } catch (e) {
      // 에러 처리
    }
  }
}
