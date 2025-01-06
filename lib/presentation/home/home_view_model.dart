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
      Feed(id: '1', imageUrl: 'https://picsum.photos/200/300'),
      Feed(id: '2', imageUrl: 'https://picsum.photos/200/300'),
      Feed(id: '3', imageUrl: 'https://picsum.photos/200/300'),
      Feed(id: '4', imageUrl: 'https://picsum.photos/200/300'),
      Feed(id: '5', imageUrl: 'https://picsum.photos/200/300'),
      Feed(id: '6', imageUrl: 'https://picsum.photos/200/300'),
      Feed(id: '7', imageUrl: 'https://picsum.photos/200/300'),
    ]);
  }

  Future<void> fetch() async {}

  void moreFetch() {
    List<Feed> moreFeed = [
      ...state!.feeds,
      Feed(id: '${count++}', imageUrl: 'https://picsum.photos/200/300')
    ];
    state = HomeState(feeds: moreFeed);
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState?>(
  () {
    return HomeViewModel();
  },
);
