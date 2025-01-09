import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/presentation/comment/comment_view_model.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_header.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_input.dart';
import 'package:diet_fairy/presentation/comment/widgets/comment_list.dart';
import 'package:diet_fairy/presentation/comment/widgets/latest_comment.dart';
import 'package:diet_fairy/presentation/providers.dart';

class CommentBottomSheet extends ConsumerStatefulWidget {
  const CommentBottomSheet({super.key});

  @override
  ConsumerState<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends ConsumerState<CommentBottomSheet> {
  static const double minHeightFactor = 0.08;
  static const double maxHeightFactor = 0.9;
  double heightFactor = minHeightFactor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(commentExpandedProvider.notifier).state = true;
    });
  }

  void _expandSheet() {
    setState(() {
      heightFactor = maxHeightFactor;
      ref.read(commentExpandedProvider.notifier).state = true;
    });
  }

  void _minimizeSheet() {
    setState(() {
      heightFactor = minHeightFactor;
      ref.read(commentExpandedProvider.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final isExpanded = ref.watch(commentExpandedProvider);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: (details) {
        setState(() {
          final newHeightFactor =
              heightFactor + (details.delta.dy / screenHeight);
          heightFactor =
              newHeightFactor.clamp(minHeightFactor, maxHeightFactor);
        });
      },
      onVerticalDragEnd: (details) {
        setState(() {
          if (details.velocity.pixelsPerSecond.dy > 0) {
            heightFactor = minHeightFactor;
          } else if (details.velocity.pixelsPerSecond.dy < 0) {
            heightFactor = maxHeightFactor;
          } else {
            heightFactor =
                heightFactor < 0.5 ? minHeightFactor : maxHeightFactor;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: MediaQuery.of(context).size.height * heightFactor,
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
            if (!isExpanded)
              LatestComment(
                comment:
                    state.comments.isNotEmpty ? state.comments.first : null,
                onTap: _expandSheet,
              )
            else
              Expanded(
                child: Column(
                  children: [
                    CommentHeader(
                      commentCount: state.comments.length,
                      onClose: _minimizeSheet,
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
              ),
          ],
        ),
      ),
    );
  }
}
