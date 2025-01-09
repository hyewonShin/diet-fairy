import 'package:flutter/material.dart';

class CommentHeader extends StatelessWidget {
  final int commentCount;
  final VoidCallback onClose;

  const CommentHeader({
    super.key,
    required this.commentCount,
    required this.onClose,
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
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}
