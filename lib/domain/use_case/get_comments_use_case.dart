import 'package:diet_fairy/domain/model/comment.dart';
import 'package:diet_fairy/domain/repository/comment_repository.dart';

class GetCommentsUseCase {
  final CommentRepository repository;

  GetCommentsUseCase(this.repository);

  Future<List<Comment>> execute() {
    return repository.getComments();
  }
}
