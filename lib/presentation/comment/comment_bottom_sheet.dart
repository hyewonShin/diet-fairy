import 'package:diet_fairy/presentation/home/home_view_model.dart';
import 'package:diet_fairy/presentation/home/widgets/home_feed_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/presentation/comment/comment_view_model.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_header.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_input.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_list.dart';

class CommentBottomSheet extends ConsumerWidget {
  const CommentBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentViewModelProvider);
    final homeState = ref.watch(homeViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final currentFeed = homeState.currentFeed;

    return Container(
      height: screenHeight * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          CommentHeader(
            commentCount: state.comments.length,
            onClose: () {
              Navigator.pop(context);
              if (currentFeed != null) {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => HomeFeedContent(true, currentFeed),
                );
              }
            },
          ),
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
