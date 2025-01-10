import 'dart:io';

import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/domain/usecase/add_feed_use_case.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteState {
  Feed? feed;
  List<File>? images;
  WriteState({required this.feed, required this.images});

  WriteState copyWith({
    Feed? feed,
    List<File>? images,
  }) {
    return WriteState(
      feed: feed ?? this.feed,
      images: images ?? this.images,
    );
  }
}

class WriteViewModel extends StateNotifier<WriteState> {
  final AddFeedUseCase addFeedUseCase;

  WriteViewModel(this.addFeedUseCase)
      : super(WriteState(feed: null, images: []));

  Future<void> addFeed(Feed? feed, List<File>? images) async {
    try {
      await addFeedUseCase.execute(feed!, images!);
      print('Feed added successfully');
    } catch (e) {
      print('Error adding feed: $e');
    }
  }
}

// Provider 정의
final writeViewModelProvider =
    StateNotifierProvider<WriteViewModel, WriteState>(
  (ref) {
    final addFeedUseCase = ref.watch(addFeedUsecaseProvider);
    return WriteViewModel(addFeedUseCase);
  },
);
