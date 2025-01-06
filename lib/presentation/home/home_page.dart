import 'package:flutter/material.dart';
import 'package:diet_fairy/presentation/comment/comment_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet Fairy'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const CommentBottomSheet(),
            );
          },
          child: const Text('댓글 보기'),
        ),
      ),
    );
  }
}
