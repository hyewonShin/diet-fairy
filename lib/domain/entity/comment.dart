class Comment {
  final int commentId;
  final String feedId;
  final String userId;
  final String userNickname;
  final String? userImageUrl;
  final String content;
  final String createdAt;

  Comment({
    required this.commentId,
    required this.feedId,
    required this.userId,
    required this.userNickname,
    this.userImageUrl,
    required this.content,
    required this.createdAt,
  });
}
