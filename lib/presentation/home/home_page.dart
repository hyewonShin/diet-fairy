import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/presentation/comment/comment_bottom_sheet.dart';
import 'package:diet_fairy/presentation/home/home_view_model.dart';
import 'package:diet_fairy/presentation/home/widgets/home_feed_content.dart';
import 'package:diet_fairy/presentation/home/widgets/home_feed_delete_button.dart';
import 'package:diet_fairy/presentation/home/widgets/home_feed_image_page_view.dart';
import 'package:diet_fairy/presentation/home/widgets/home_popup_menu_button.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:diet_fairy/util/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:diet_fairy/presentation/home/widgets/report_dialog.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage(User user, {super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // 게시물 자세히 보기
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final vm = ref.watch(homeViewModelProvider.notifier);
    final padding = MediaQuery.of(context).padding;

    // 데이터 불러오는 동안 로딩 화면 보여주기
    if (state.feeds == null) {
      return Lottie.asset('assets/loading1.json');
    }

    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: state.feeds!.length,
        onPageChanged: (page) async {
          // 페이지 이동할 때 게시물 자세히 보기 false 처리
          selected = false;

          // 페이지가 이동될 때마다 현재 피드 정보를 업데이트
          final feed = state.feeds![page];
          vm.upateCurrentFeed(feed);

          // 마지막 페이지일 경우 추가 피드를 가져온다
          if (page + 1 == state.feeds!.length) {
            final result = await vm.moreFetch(feed.createdAt);

            if (result != null) {
              // TODO: 마지막 게시글일 때 dialog 띄우는 건데 현재 동작 안함 개선 필요
              await customCupertinoDialog(
                  context: context, title: null, content: result);
            }
          }
        },
        itemBuilder: (context, feedIndex) {
          final feed = state.feeds![feedIndex];
          final user = ref.read(userGlobalViewModelProvider);

          return Stack(
            children: [
              // 피드 사진
              HomeFeedImagePageView(feed),

              // 본인이 작성한 피드에는 삭제 버튼, 아닌 경우 신고 버튼 생성
              Positioned(
                top: padding.top,
                left: 10,
                child: user!.userId == feed.userId
                    ? HomeFeedDeleteButton(feedId: feed.id)
                    : IconButton(
                        icon: const Icon(
                          Icons.report_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ReportDialog(feedId: feed.id),
                          );
                        },
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

              // 게시물 자세히 볼 container 박스
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: HomeFeedContent(selected, feed),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
