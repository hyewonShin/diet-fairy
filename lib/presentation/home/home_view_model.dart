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

  void moreFetch() {
    List<Feed> moreFeed = [
      ...state.feeds!,
      Feed(
        id: 2,
        userId: 'userId2',
        userNickname: '유저2',
        userImageUrl: 'https://picsum.photos/200/300',
        imageUrl: ['https://picsum.photos/200/300'],
        tag: [],
        content: 'content2',
        createdAt: DateTime.now(),
        likeCnt: 0,
        isLike: false,
      ),
    ];
    state = HomeState(feeds: moreFeed);
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(
  () {
    return HomeViewModel();
  },
);
