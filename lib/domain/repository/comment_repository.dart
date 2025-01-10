import 'package:diet_fairy/domain/entity/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getComments(String feedId);
  Future<void> addComment(String feedId, String content);
}
