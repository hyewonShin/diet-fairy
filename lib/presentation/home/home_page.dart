import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/presentation/comment/comment_bottom_sheet.dart';
import 'package:diet_fairy/presentation/home/home_view_model.dart';
import 'package:diet_fairy/presentation/home/widgets/home_popup_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage(User user, {super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider)!;
    final vm = ref.watch(homeViewModelProvider.notifier);
    final padding = MediaQuery.of(context).padding;

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
                  state.feeds[index].id.toString(),
                  style: TextStyle(fontSize: 100),
                ),
              ),
              // 마이페이지, 글작성 페이지 이동하는 팝업 메뉴
              Positioned(
                top: padding.top,
                right: 10,
                child: HomePopupMenuButton(),
              ),
            ],
          );
        },
      ),
      bottomSheet: CommentBottomSheet(),
    );
  }
}
