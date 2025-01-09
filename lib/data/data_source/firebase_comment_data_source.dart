import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/dto/comment_dto.dart';

class FirebaseCommentDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<List<CommentDto>> getComments() async {
    final snapshot = await _firestore
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id; // Firestore 문서 ID 추가
      return CommentDto.fromJson(data);
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
