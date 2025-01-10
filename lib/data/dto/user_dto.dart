import 'package:diet_fairy/domain/entity/user.dart';

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

  // Entity로 변환하는 메서드
  User toEntity() {
    return User(
      userId: userId,
      nickname: nickname,
      imageUrl: imageUrl,
      feedCreatedAt: feedCreatedAt,
      weight: weight,
      desiredWeight: desiredWeight,
      likeFeed: likeFeed?.map((e) => e.toString()).toList(),
    );
  }

  // Entity에서 DTO로 변환하는 팩토리 메서드
  factory UserDto.fromEntity(User user) {
    return UserDto(
      userId: user.userId,
      nickname: user.nickname,
      imageUrl: user.imageUrl,
      feedCreatedAt: user.feedCreatedAt,
      weight: user.weight,
      desiredWeight: user.desiredWeight,
      likeFeed: user.likeFeed?.map((e) => int.parse(e)).toList(),
    );
  }
}
