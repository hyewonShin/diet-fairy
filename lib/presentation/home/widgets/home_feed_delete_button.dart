import 'package:diet_fairy/presentation/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
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
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text(
                    '정말 삭제하시겠습니까?',
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () async {
                          await ref
                              .read(homeViewModelProvider.notifier)
                              .deleteFeed(feedId);
                          Navigator.of(context).pop();
                        },
                        child: const Text('확인')),
                    CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('취소'))
                  ],
                );
              });
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
