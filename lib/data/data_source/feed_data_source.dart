import 'dart:io';

import 'package:diet_fairy/data/dto/feed_dto.dart';

abstract interface class FeedDataSource {
  /// 게시물 5개만 가져오는 api
  Future<List<FeedDto>?> getFeeds();

  /// 게시물 id 기준 최신 게시물 5개만 가져오는 api
  Future<List<FeedDto>?> getMoreFeeds(int feedId);

  Future<void> addFeed(FeedDto feed, List<File> images);
}
