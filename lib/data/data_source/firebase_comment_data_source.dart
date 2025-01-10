import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/dto/comment_dto.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseCommentDataSource {
  final _firestore = FirebaseFirestore.instance;
  final Ref ref;

  FirebaseCommentDataSource(this.ref);

  Future<List<CommentDto>> getComments(String feedId) async {
    try {
      print('Fetching comments for feedId: $feedId');

      final snapshot = await _firestore
          .collection('comments')
          .where('feedId', isEqualTo: feedId)
          .get();

      print('Found ${snapshot.docs.length} comments');

      final comments = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return CommentDto.fromJson(data);
      }).toList();

      comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return comments;
    } catch (e) {
      print('Error getting comments: $e');
      print('Stack trace: ${StackTrace.current}');
      return [];
    }
  }

  Future<void> addComment(String feedId, String content) async {
    try {
      final user = ref.read(userGlobalViewModelProvider);
      print('Current user: ${user?.nickname}');

      if (user == null) {
        print('No user found!');
        return;
      }

      final commentData = {
        'feedId': feedId,
        'userId': user.userId,
        'nickname': user.nickname,
        'userImageUrl': user.imageUrl,
        'content': content,
        'createdAt': FieldValue.serverTimestamp(),
      };

      print('Adding comment: $commentData');

      await _firestore.collection('comments').add(commentData);
      print('Comment added successfully');
    } catch (e) {
      print('Error adding comment: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }
}
