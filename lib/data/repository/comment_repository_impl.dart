import 'package:diet_fairy/data/data_source/firebase_comment_data_source.dart';
import 'package:diet_fairy/domain/model/comment.dart';
import 'package:diet_fairy/domain/repository/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final FirebaseCommentDataSource _dataSource;

  CommentRepositoryImpl(this._dataSource);

  @override
  Future<List<Comment>> getComments() async {
    return await _dataSource.getComments();
  }

  @override
  Future<void> addComment(String content) async {
    await _dataSource.addComment(content);
  }
}
