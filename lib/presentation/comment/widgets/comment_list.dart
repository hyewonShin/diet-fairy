import 'package:flutter/material.dart';
import 'package:diet_fairy/domain/model/comment.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_item.dart';

class CommentList extends StatelessWidget {
  final List<Comment> comments;

  const CommentList({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentItem(
          comment: comments[index],
        );
      },
    );
  }
}
