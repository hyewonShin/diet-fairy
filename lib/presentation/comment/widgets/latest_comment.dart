import 'package:flutter/material.dart';
import 'package:diet_fairy/domain/entity/comment.dart';

class LatestComment extends StatelessWidget {
  final Comment? comment;
  final VoidCallback onTap;

  const LatestComment({
    super.key,
    this.comment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: comment != null
                  ? Text(
                      comment!.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    )
                  : const Text(
                      '첫 댓글을 남겨보세요!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
            ),
            const Icon(Icons.keyboard_arrow_up, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
