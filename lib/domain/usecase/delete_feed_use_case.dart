import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/domain/repository/feed_repository.dart';

class DeleteFeedUseCase {
  final FeedRepository repository;

  DeleteFeedUseCase(this.repository);

  Future<void> execute(String feedId) {
    return repository.deleteFeed(feedId);
  }
}
