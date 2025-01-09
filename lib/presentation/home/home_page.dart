import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/presentation/comment/comment_bottom_sheet.dart';
import 'package:diet_fairy/presentation/home/home_view_model.dart';
import 'package:diet_fairy/presentation/home/widgets/home_feed_image_page_view.dart';
import 'package:diet_fairy/presentation/home/widgets/home_popup_menu_button.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:diet_fairy/util/dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage(User user, {super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // 현재 보고 있는 피드의 인덱스를 저장
  int currentFeedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final vm = ref.watch(homeViewModelProvider.notifier);
    final padding = MediaQuery.of(context).padding;

    // 데이터 불러오는 동안 로딩 화면 보여주기
    if (state.feeds == null) {
      return Lottie.asset('assets/loading.json');
    }

    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: state.feeds!.length,
        onPageChanged: (page) async {
          setState(() {
            currentFeedIndex = page; // 페이지 변경 시 인덱스 업데이트
          });
          // 마지막 페이지일 경우 추가 피드를 가져온다
          if (page + 1 == state.feeds!.length) {
            final lastFeedId = state.feeds![page].id;
            final result = await vm.moreFetch(lastFeedId);
            if (result != null) {
              // TODO: 마지막 게시글일 때 dialog 띄우는 건데 현재 동작 안함 개선 필요
              await customCupertinoDialog(
                  context: context, title: null, content: result);
            }
          }
        },
        itemBuilder: (context, feedIndex) {
          final feed = state.feeds![feedIndex];

          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  // 피드 영역 탭했을 때 댓글창 최소화
                  if (ref.read(commentExpandedProvider)) {
                    ref.read(commentExpandedProvider.notifier).state = false;
                  }
                },
                child: HomeFeedImagePageView(feed),
              ),
              Center(
                child: Text(
                  state.feeds![feedIndex].id.toString(),
                  style: TextStyle(fontSize: 100),
                ),
              ),
              // 마이페이지, 글작성 페이지 이동하는 팝업 메뉴
              Positioned(
                top: padding.top,
                right: 10,
                child: HomePopupMenuButton(),
              ),
              // 좋아요 기능
              // Positioned(
              //   right: 10,
              //   bottom: MediaQuery.of(context).size.height * 0.2 + 20,
              //   child: Container(
              //     height: 50,
              //     width: 50,
              //     color: Colors.transparent,
              //     child: Icon(
              //       Icons.favorite_border,
              //       size: 30,
              //     ),
              //   ),
              // )
            ],
          );
        },
      ),
      bottomSheet: state.feeds != null
          ? CommentProvider(
              feedId: state.feeds![currentFeedIndex].id,
              child: const CommentBottomSheet(),
            )
          : null,
    );
  }
}
