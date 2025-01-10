import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  List<Feed>? feeds;
  Feed? currentFeed;
  HomeState({
    required this.feeds,
    required this.currentFeed,
  });

  HomeState copyWith({
    List<Feed>? feeds,
    Feed? currentFeed,
  }) {
    return HomeState(
      feeds: feeds ?? this.feeds,
      currentFeed: currentFeed ?? this.currentFeed,
    );
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    fetch();
    return HomeState(feeds: null, currentFeed: null);
  }

  Future<void> fetch() async {
    final fetchFeedUsecase = ref.read(fetchFeedUsecaseProvider);
    final feeds = await fetchFeedUsecase.execute();
    state = HomeState(feeds: feeds!, currentFeed: feeds.first);
  }

  Future<String?> moreFetch(int feedId) async {
    final fetchMoreFeedUsecase = ref.read(fetchMoreFeedUsecaseProvider);
    final moreFeeds = await fetchMoreFeedUsecase.execute(feedId);

    if (moreFeeds == null) {
      return '마지막 게시글입니다.';
    }

    List<Feed> moreFeed = [
      ...state.feeds!,
      ...moreFeeds,
    ];

    // 상태 업데이트
    state = state.copyWith(feeds: moreFeed);
    return null;
  }

  void upateCurrentFeed(Feed feed) {
    state = state.copyWith(currentFeed: feed);
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(
  () {
    return HomeViewModel();
  },
);
