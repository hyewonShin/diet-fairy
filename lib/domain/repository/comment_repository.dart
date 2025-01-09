import 'package:diet_fairy/domain/entity/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getComments();
  Future<void> addComment(String content);
}
