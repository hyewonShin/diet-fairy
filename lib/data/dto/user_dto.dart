class UserDto {
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
  List<int>? likeFeed;

  UserDto({
    required this.userId,
    required this.nickname,
    required this.imageUrl,
    required this.feedCreatedAt,
    required this.weight,
    required this.desiredWeight,
    required this.likeFeed,
  });

  UserDto.fromJson(Map<String, dynamic> map)
      : this(
          userId: map['userId'],
          nickname: map['nickname'],
          imageUrl: map['imageUrl'],
          feedCreatedAt: List.from(map['feedCreatedAt']),
          weight: map['weight'],
          desiredWeight: map['desiredWeight'],
          likeFeed: List.from(map['likeFeed']),
        );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'imageUrl': imageUrl,
      'feedCreatedAt': feedCreatedAt,
      'weight': weight,
      'desiredWeight': desiredWeight,
      'likeFeed': likeFeed,
    };
  }
}
