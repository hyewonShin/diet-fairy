import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/domain/entity/comment.dart';

class CommentDto {
  final String id;
  final String userId;
  final String userNickname;
  final String content;
  final DateTime createdAt;

  CommentDto({
    required this.id,
    required this.userId,
    required this.userNickname,
    required this.content,
    required this.createdAt,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userNickname: json['userNickname'] as String,
      content: json['content'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userNickname': userNickname,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Entity로 변환하는 메서드
  Comment toEntity() {
    return Comment(
      commentId: id.hashCode,
      userId: userId,
      userNickname: userNickname,
      content: content,
      createdAt: createdAt,
    );
  }

  // Entity에서 DTO로 변환하는 팩토리 메서드
  factory CommentDto.fromEntity(Comment comment) {
    return CommentDto(
      id: comment.commentId.toString(),
      userId: comment.userId,
      userNickname: comment.userNickname,
      content: comment.content,
      createdAt: comment.createdAt,
    );
  }
}
