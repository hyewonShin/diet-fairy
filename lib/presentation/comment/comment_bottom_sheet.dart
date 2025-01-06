import 'package:flutter/material.dart';
import 'package:diet_fairy/domain/model/comment.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_header.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_input.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_list.dart';

/// 댓글 목록을 보여주는 바텀시트
class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  // 댓글 목록을 저장할 상태 변수
  final List<Comment> comments = [
    Comment(
      id: '3378',
      content: '너무너무 맛있어 보여요😋',
      createdAt: DateTime(2025, 1, 3),
      userId: '익명의 다이어터3378',
    ),
    Comment(
      id: '3379',
      content: '꿀팁 감사해요><',
      createdAt: DateTime(2025, 1, 3),
      userId: '익명의 다이어터3379',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          CommentHeader(commentCount: comments.length),
          Expanded(
            child: CommentList(comments: comments),
          ),
          const CommentInput(),
        ],
      ),
    );
  }
}
