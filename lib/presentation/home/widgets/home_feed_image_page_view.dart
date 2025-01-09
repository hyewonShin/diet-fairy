import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:flutter/material.dart';

class HomeFeedImagePageView extends StatelessWidget {
  HomeFeedImagePageView(this.feed);
  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: feed.imageUrl.length,
      itemBuilder: (context, imageIndex) {
        final feedImageUrls = feed.imageUrl;

        return Container(
          height: double.infinity,
          width: double.infinity,
          // 팝업 메뉴바 투명도 주기 위해 container 색상 투명으로 지정함
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Image.network(
            feedImageUrls[imageIndex],
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}
