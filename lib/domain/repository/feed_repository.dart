import 'dart:io';

import 'package:diet_fairy/domain/entity/feed.dart';

abstract interface class FeedRepository {
  Future<List<Feed>?> getFeeds();

  Future<List<Feed>?> getMoreFeeds(int feedId);

  Future<void> addFeed(Feed feed, List<File> images);
}
