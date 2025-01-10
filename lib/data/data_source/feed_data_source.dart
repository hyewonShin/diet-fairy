import 'package:diet_fairy/data/dto/feed_dto.dart';
import 'package:diet_fairy/domain/entity/user.dart';

abstract interface class FeedDataSource {
  /// 게시물 5개만 가져오는 api
  Future<List<FeedDto>?> getFeeds();

  /// 게시물 id 기준 최신 게시물 5개만 가져오는 api
  Future<List<FeedDto>?> getMoreFeeds(DateTime feedCreatedAt);

  Future<void> addFeed(
    User user,
    String content,
    List<String> tag,
    List<String> images,
  );
}
