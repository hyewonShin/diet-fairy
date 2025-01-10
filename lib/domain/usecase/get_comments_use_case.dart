import 'package:diet_fairy/domain/entity/comment.dart';
import 'package:diet_fairy/domain/repository/comment_repository.dart';

class GetCommentsUseCase {
  final CommentRepository repository;

  GetCommentsUseCase(this.repository);

  Future<List<Comment>> execute(String feedId) {
    return repository.getComments(feedId);
  }
}
