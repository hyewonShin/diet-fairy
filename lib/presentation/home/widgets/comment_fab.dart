import 'package:flutter/material.dart';
import 'package:diet_fairy/presentation/comment/comment_bottom_sheet.dart';

class CommentFAB extends StatelessWidget {
  const CommentFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const CommentBottomSheet(),
        );
      },
      label: const Text('댓글 보기'),
      icon: const Icon(Icons.comment),
    );
  }
}
