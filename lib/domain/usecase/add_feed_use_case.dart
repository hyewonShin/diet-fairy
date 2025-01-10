import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/domain/repository/feed_repository.dart';

class AddFeedUseCase {
  final FeedRepository repository;

  AddFeedUseCase(this.repository);

  Future<void> execute(
    User user,
    String content,
    List<String> tag,
    List<String> images,
  ) {
    return repository.addFeed(user, content, tag, images);
  }
}
