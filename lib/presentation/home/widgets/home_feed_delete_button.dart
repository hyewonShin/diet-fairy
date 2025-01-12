import 'package:diet_fairy/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFeedDeleteButton extends ConsumerWidget {
  final feedId;
  const HomeFeedDeleteButton({super.key, required this.feedId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        try {
          await ref.read(homeViewModelProvider.notifier).deleteFeed(feedId);
        } catch (e) {
          print('피드 삭제 중 오류 발생: $e');
        }
      },
      child: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }
}
