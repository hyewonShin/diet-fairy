import 'package:flutter/material.dart';

class CommentHeader extends StatelessWidget {
  final int commentCount;

  const CommentHeader({
    super.key,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            '댓글 $commentCount',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
