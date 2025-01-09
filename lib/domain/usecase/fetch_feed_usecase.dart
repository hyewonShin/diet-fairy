import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/domain/repository/feed_repository.dart';

class FetchFeedUsecase {
  FetchFeedUsecase(this._feedRepository);
  final FeedRepository _feedRepository;

  Future<List<Feed>?> execute() async {
    return await _feedRepository.getFeeds();
  }
}
