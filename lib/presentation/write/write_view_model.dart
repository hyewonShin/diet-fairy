import 'package:diet_fairy/presentation/providers.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteState {
  String? content;
  List<String> tag;
  List<String> images;

  WriteState({
    required this.content,
    required this.tag,
    required this.images,
  });

  WriteState copyWith({
    String? content,
    List<String>? tag,
    List<String>? images,
  }) {
    return WriteState(
      content: content ?? this.content,
      tag: tag ?? this.tag,
      images: images ?? this.images,
    );
  }
}

class WriteViewModel extends Notifier<WriteState> {
  @override
  WriteState build() {
    return WriteState(content: null, tag: [], images: []);
  }

  Future<void> addFeed(
      String content, List<String> tag, List<String> images) async {
    final addFeedUseCase = ref.watch(addFeedUsecaseProvider);
    final user = ref.read(userGlobalViewModelProvider);

    if (user == null) {
      print('존재하지 않는 사용자입니다.');
      return;
    }

    await addFeedUseCase.execute(user, content, tag, images);
  }
}

// Provider 정의
final writeViewModelProvider = NotifierProvider<WriteViewModel, WriteState>(
  () {
    return WriteViewModel();
  },
);
