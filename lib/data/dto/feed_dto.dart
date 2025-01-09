class FeedDto {
  /// 게시물 id
  int id;

  /// 게시물 올린 user 의 id
  String userId;

  /// 게시물 올린 user 의 닉네임
  String userNickname;

  /// 게시물 올린 user 의 프로필 사진
  String? userImageUrl;

  /// 게시물 이미지
  List<String> imageUrl;

  /// 게시물 태그
  List<String>? tag;

  /// 게시물 내용
  String content;

  /// 게시물 올린 날짜
  DateTime createdAt;

  //List<int>? comment

  /// 게시물 좋아요 수
  int likeCnt = 0;

  /// 게시물 좋아요 표시
  bool isLike = false;

  FeedDto({
    required this.id,
    required this.userId,
    required this.userNickname,
    required this.userImageUrl,
    required this.imageUrl,
    required this.tag,
    required this.content,
    required this.createdAt,
    required this.likeCnt,
    required this.isLike,
  });

  FeedDto.fromJson(Map<String, dynamic> map)
      : this(
          id: map['id'],
          userId: map['userId'],
          userNickname: map['userNickname'],
          userImageUrl: map['userImageUrl'],
          imageUrl: List.from(map['imageUrl']),
          tag: List.from(map['tag']),
          content: map['content'],
          createdAt: DateTime.parse(map['createdAt']),
          likeCnt: map['likeCnt'],
          isLike: map['isLike'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userNickname': userNickname,
      'userImageUrl': userImageUrl,
      'imageUrl': imageUrl,
      'tag': tag,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'likeCnt': likeCnt,
      'isLike': isLike,
    };
  }
}
