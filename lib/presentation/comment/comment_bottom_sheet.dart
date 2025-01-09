import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/presentation/comment/comment_view_model.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_header.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_input.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_list.dart';

/// 댓글 목록을 보여주는 바텀시트
class CommentBottomSheet extends ConsumerWidget {
  const CommentBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentViewModelProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          CommentHeader(commentCount: state.comments.length),
          if (state.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: CommentList(comments: state.comments),
            ),
          const CommentInput(),
        ],
      ),
    );
  }
}
