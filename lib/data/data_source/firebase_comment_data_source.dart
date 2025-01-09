import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/domain/model/comment.dart';

class FirebaseCommentDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Comment>> getComments() async {
    final snapshot = await _firestore
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Comment(
        commentId: doc.id.hashCode,
        userId: data['userId'] ?? '',
        userNickname: data['userNickname'] ?? '',
        content: data['content'] ?? '',
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    }).toList();
  }

  Future<void> addComment(String content) async {
    await _firestore.collection('comments').add({
      'userId': 'current_user_id', // Firebase Auth에서 가져올 수 있음
      'userNickname': '익명의 다이어터',
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
