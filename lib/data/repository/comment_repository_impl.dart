import 'package:diet_fairy/data/data_source/firebase_comment_data_source.dart';
import 'package:diet_fairy/domain/entity/comment.dart';
import 'package:diet_fairy/domain/repository/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final FirebaseCommentDataSource _dataSource;

  CommentRepositoryImpl(this._dataSource);
  @override
  Future<List<Comment>> getComments(int feedId) async {
    final dtos = await _dataSource.getComments(feedId);
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> addComment(int feedId, String content) async {
    await _dataSource.addComment(feedId.toString(), content);
  }
}
