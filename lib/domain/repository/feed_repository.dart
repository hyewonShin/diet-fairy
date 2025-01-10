import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/domain/entity/user.dart';

abstract interface class FeedRepository {
  Future<List<Feed>?> getFeeds();

  Future<List<Feed>?> getMoreFeeds(DateTime feedCreatedAt);

  Future<void> addFeed(
    User user,
    String content,
    List<String> tag,
    List<String> images,
  );
}
