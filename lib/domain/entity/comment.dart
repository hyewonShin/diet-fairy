class Comment {
  final int commentId;
  final String userId;
  final String userNickname;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.commentId,
    required this.userId,
    required this.userNickname,
    required this.content,
    required this.createdAt,
  });
}
