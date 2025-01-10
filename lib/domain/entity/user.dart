class User {
  /// 유저 id
  /// Firebase Authentication 의 사용자 UID
  String userId;

  /// 유저 닉네임
  String nickname;

  /// 유저 프로필 사진
  String? imageUrl;

  /// 유저 게시물 생성일
  List<DateTime>? feedCreatedAt;

  /// 유저 현재 몸무게
  int weight;

  /// 유저 목표 몸무게
  int desiredWeight;

  /// 유저가 좋아요 한 게시물 id
  List<String>? likeFeed;

  User({
    required this.userId,
    required this.nickname,
    this.imageUrl,
    required this.weight,
    required this.desiredWeight,
    this.feedCreatedAt,
    this.likeFeed,
  });

  User copyWith({
    String? userId,
    String? nickname,
    String? imageUrl,
    int? weight,
    int? desiredWeight,
    List<DateTime>? feedCreatedAt,
    List<String>? likeFeed,
  }) {
    return User(
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      imageUrl: imageUrl ?? this.imageUrl,
      weight: weight ?? this.weight,
      desiredWeight: desiredWeight ?? this.desiredWeight,
      feedCreatedAt: feedCreatedAt ?? this.feedCreatedAt,
      likeFeed: likeFeed ?? this.likeFeed,
    );
  }
}
