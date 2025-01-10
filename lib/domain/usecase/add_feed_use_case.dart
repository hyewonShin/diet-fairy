import 'dart:io';

import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/domain/repository/feed_repository.dart';

class AddFeedUseCase {
  final FeedRepository repository;

  AddFeedUseCase(this.repository);

  Future<void> execute(Feed feed, List<File> images) {
    return repository.addFeed(feed, images);
  }
}
