import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/domain/entity/comment.dart';

class CommentDto {
  final String id;
  final String feedId;
  final String userId;
  final String userNickname;
  final String? userImageUrl;
  final String content;
  final String createdAt;

  CommentDto({
    required this.id,
    required this.feedId,
    required this.userId,
    required this.userNickname,
    this.userImageUrl,
    required this.content,
    required this.createdAt,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      id: json['id'] as String,
      feedId: json['feedId'],
      userId: json['userId'] as String,
      userNickname: json['nickname'] as String,
      userImageUrl: json['userImageUrl'] as String?,
      content: json['content'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feedId': feedId,
      'userId': userId,
      'nickname': userNickname,
      'userImageUrl': userImageUrl,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  // Entity로 변환하는 메서드
  Comment toEntity() {
    return Comment(
      commentId: id.hashCode,
      feedId: feedId,
      userId: userId,
      userNickname: userNickname,
      userImageUrl: userImageUrl,
      content: content,
      createdAt: createdAt,
    );
  }

  // Entity에서 DTO로 변환하는 팩토리 메서드
  factory CommentDto.fromEntity(Comment comment) {
    return CommentDto(
      id: comment.commentId.toString(),
      feedId: comment.feedId,
      userId: comment.userId,
      userNickname: comment.userNickname,
      userImageUrl: comment.userImageUrl,
      content: comment.content,
      createdAt: comment.createdAt,
    );
  }
}
