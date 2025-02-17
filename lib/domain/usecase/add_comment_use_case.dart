import 'package:diet_fairy/domain/repository/comment_repository.dart';

class AddCommentUseCase {
  final CommentRepository repository;

  AddCommentUseCase(this.repository);

  Future<void> execute(String feedId, String content) {
    return repository.addComment(feedId, content);
  }
}
