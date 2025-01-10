import 'dart:io';

import 'package:diet_fairy/data/data_source/feed_data_source.dart';
import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/domain/repository/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource _feedDataSource;
  FeedRepositoryImpl(this._feedDataSource);

  @override
  Future<List<Feed>?> getFeeds() async {
    final feedDto = await _feedDataSource.getFeeds();

    if (feedDto == null) {
      return null;
    }

    return feedDto.map(
      (e) {
        return Feed(
          id: e.id,
          userId: e.userId,
          userNickname: e.userNickname,
          userImageUrl: e.userImageUrl,
          imageUrl: e.imageUrl,
          tag: e.tag,
          content: e.content,
          createdAt: e.createdAt,
          likeCnt: e.likeCnt,
          isLike: e.isLike,
        );
      },
    ).toList();
  }

  @override
  Future<List<Feed>?> getMoreFeeds(DateTime feedCreatedAt) async {
    final feedDto = await _feedDataSource.getMoreFeeds(feedCreatedAt);

    if (feedDto == null) {
      return null;
    }

    return feedDto.map(
      (e) {
        return Feed(
          id: e.id,
          userId: e.userId,
          userNickname: e.userNickname,
          userImageUrl: e.userImageUrl,
          imageUrl: e.imageUrl,
          tag: e.tag,
          content: e.content,
          createdAt: e.createdAt,
          likeCnt: e.likeCnt,
          isLike: e.isLike,
        );
      },
    ).toList();
  }

  @override
  Future<void> addFeed(Feed feed, List<File> images) async {
    try {
      // Feed -> FeedDto 변환
      final feedDto = feed.toDto();

      // FeedDto와 이미지를 dataSource에 전달
      await _feedDataSource.addFeed(feedDto, images);

      print("Feed addFeed successfully");
    } catch (e) {
      print("Error in addFeed: $e");
    }
  }
}
