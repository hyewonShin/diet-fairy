import 'package:flutter/material.dart';
import 'package:diet_fairy/presentation/home/widgets/home_app_bar.dart';
import 'package:diet_fairy/presentation/home/widgets/home_content.dart';
import 'package:diet_fairy/presentation/home/widgets/comment_fab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: HomeContent(),
      floatingActionButton: CommentFAB(),
    );
  }
}
