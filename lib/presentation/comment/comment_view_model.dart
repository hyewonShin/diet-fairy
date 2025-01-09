import 'package:diet_fairy/domain/usecase/add_comment_use_case.dart';
import 'package:diet_fairy/domain/usecase/get_comments_use_case.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/domain/entity/comment.dart';
import 'package:diet_fairy/domain/usecase/comment_use_cases_provider.dart';

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
    StateNotifierProvider.autoDispose<CommentViewModel, CommentState>((ref) {
  final feedId = ref.watch(currentFeedIdProvider);

  return CommentViewModel(
    getCommentsUseCase: ref.watch(getCommentsUseCaseProvider),
    addCommentUseCase: ref.watch(addCommentUseCaseProvider),
    feedId: feedId,
  );
}, dependencies: [currentFeedIdProvider]);

class CommentViewModel extends StateNotifier<CommentState> {
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  final int feedId;

  CommentViewModel({
    required this.getCommentsUseCase,
    required this.addCommentUseCase,
    required this.feedId,
  }) : super(CommentState()) {
    getComments();
  }

  Future<void> getComments() async {
    print('Getting comments for feedId: $feedId');
    state = state.copyWith(isLoading: true);
    try {
      final comments = await getCommentsUseCase.execute(feedId);
      print('Received ${comments.length} comments');
      state = state.copyWith(
        comments: comments,
        isLoading: false,
      );
    } catch (e) {
      print('Error in getComments: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> addComment(String content) async {
    print('Adding comment: $content for feedId: $feedId');
    try {
      await addCommentUseCase.execute(feedId, content);
      await getComments();
      print('Comment added and refreshed');
    } catch (e) {
      print('Error adding comment: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }
}
