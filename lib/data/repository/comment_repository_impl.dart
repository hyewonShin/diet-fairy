import 'package:diet_fairy/domain/model/comment.dart';
import 'package:diet_fairy/domain/repository/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  @override
  Future<List<Comment>> getComments() async {
    return [];
  }

  @override
  Future<void> addComment(String content) async {
    return;
  }
}
