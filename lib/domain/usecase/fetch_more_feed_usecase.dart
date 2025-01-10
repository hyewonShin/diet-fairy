import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/domain/repository/feed_repository.dart';

class FetchMoreFeedUsecase {
  FetchMoreFeedUsecase(this._feedRepo);
  final FeedRepository _feedRepo;

  Future<List<Feed>?> execute(DateTime feedCreatedAt) async {
    return await _feedRepo.getMoreFeeds(feedCreatedAt);
  }
}
