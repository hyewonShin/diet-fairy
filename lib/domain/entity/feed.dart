import 'package:diet_fairy/data/dto/feed_dto.dart';

class Feed {
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

  Feed({
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

  /// Feed -> FeedDto 변환
  FeedDto toDto() {
    return FeedDto(
      id: id,
      userId: userId,
      userNickname: userNickname,
      userImageUrl: userImageUrl,
      imageUrl: imageUrl,
      tag: tag,
      content: content,
      createdAt: createdAt,
      likeCnt: likeCnt,
      isLike: isLike,
    );
  }
}
