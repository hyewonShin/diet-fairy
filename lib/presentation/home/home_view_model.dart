import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  List<Feed> feeds;
  HomeState({required this.feeds});

  HomeState copy({List<Feed>? feeds}) {
    return HomeState(feeds: feeds ?? this.feeds);
  }
}

class HomeViewModel extends Notifier<HomeState?> {
  int count = 7;
  @override
  HomeState? build() {
    fetch();
    return HomeState(feeds: [
      Feed(
        id: 1,
        userId: 'userId',
        imageUrl: 'https://picsum.photos/200/300',
        content: 'content',
        createdAt: DateTime.now(),
        likeCnt: 0,
        isLike: false,
      ),
    ]);
  }

  Future<void> fetch() async {}

  void moreFetch() {
    List<Feed> moreFeed = [
      ...state!.feeds,
      Feed(
        id: 2,
        userId: 'userId2',
        imageUrl: 'https://picsum.photos/200/300',
        content: 'content2',
        createdAt: DateTime.now(),
        likeCnt: 0,
        isLike: false,
      ),
    ];
    state = HomeState(feeds: moreFeed);
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState?>(
  () {
    return HomeViewModel();
  },
);
