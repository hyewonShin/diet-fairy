import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeFeedContent extends StatelessWidget {
  HomeFeedContent(this.selected, this.feed);
  final bool selected;
  final Feed feed;

  @override
  Widget build(BuildContext context) {
    // TODO: 왜 두번 호출되는지 확인...
    print('feed ==> ${feed.id}');
    print('feed.tag => ${feed.tag}');

    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: selected
          ? MediaQuery.of(context).size.height * 0.6
          : MediaQuery.of(context).size.height * 0.15,
      alignment: selected ? Alignment.center : Alignment.bottomCenter,
      duration: const Duration(microseconds: 1),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        children: [
          Row(
            children: [
              // 유저 이미지
              _userImage(),

              const SizedBox(width: 15),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 유저 닉네임
                  Text(
                    feed.userNickname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // 게시물 날짜
                  Text(DateFormat('y년 M월 d일').format(feed.createdAt)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 게시물 내용
          Text(
            feed.content,
            style: const TextStyle(fontSize: 16),
          ),

          // 게시물 태그
          // TODO: 주석 해제해야함...
          // Expanded(
          //   child: ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: feed.tag!.length,
          //     separatorBuilder: (context, index) => const SizedBox(width: 5),
          //     itemBuilder: (context, index) {
          //       final tag = feed.tag![index];
          //       return Text('#$tag');
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  SizedBox _userImage() {
    return SizedBox(
      height: 50,
      width: 50,
      child: ClipOval(
        child: Image.asset(
          'assets/no-user-image.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
