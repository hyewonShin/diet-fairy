import 'package:diet_fairy/domain/entity/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getComments(int feedId);
  Future<void> addComment(int feedId, String content);
}
