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
        userNickname: '유저1',
        userImageUrl: 'https://picsum.photos/200/300',
        imageUrl: [
          'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FPFwMQ%2FbtsK6yrl4Iz%2FsRzYlQ6IMH0KyNSuPAS7Mk%2Fimg.jpg',
          'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcyILwY%2FbtsK7NIgpUc%2FwnqHAYfG9HTgJL8o1CyTZK%2Fimg.png'
        ],
        tag: [],
        content: 'content',
        createdAt: DateTime.now(),
        likeCnt: 0,
        isLike: false,
      ),
      Feed(
        id: 3,
        userId: 'userId',
        userNickname: '유저2',
        userImageUrl: 'https://picsum.photos/200/300',
        imageUrl: ['https://picsum.photos/200/300'],
        tag: [],
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

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState?>(
  () {
    return HomeViewModel();
  },
);
