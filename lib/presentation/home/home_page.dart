import 'package:diet_fairy/presentation/comment/comment_bottom_sheet.dart';
import 'package:diet_fairy/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider)!;
    final vm = ref.watch(homeViewModelProvider.notifier);

    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: state.feeds.length,
        onPageChanged: (page) {
          // 마지막 페이지일 경우 추가 피드를 가져온다
          if (page + 1 == state.feeds.length) {
            vm.moreFetch();
          }
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.network(
                  state.feeds[index].imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Text(
                  state.feeds[index].id,
                  style: TextStyle(fontSize: 100),
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: CommentBottomSheet(),
    );
  }
}
