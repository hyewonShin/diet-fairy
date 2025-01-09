import 'package:diet_fairy/data/dto/feed_dto.dart';

abstract interface class FeedDataSource {
  Future<List<FeedDto>?> getFeeds();
}
