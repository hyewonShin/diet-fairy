import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  List<Feed>? feeds;
  HomeState({required this.feeds});

  HomeState copy({List<Feed>? feeds}) {
    return HomeState(feeds: feeds ?? this.feeds);
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    fetch();
    return HomeState(feeds: null);
  }

  Future<void> fetch() async {
    final fetchFeedUsecase = ref.read(fetchFeedUsecaseProvider);
    final feeds = await fetchFeedUsecase.execute();
    state = HomeState(feeds: feeds!);
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
    state = HomeState(feeds: moreFeed);
    return null;
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(
  () {
    return HomeViewModel();
  },
);
