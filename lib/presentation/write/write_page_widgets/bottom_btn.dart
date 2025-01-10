import 'dart:io';

import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:diet_fairy/presentation/write/write_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget bottomBtn({
  required context,
  contentValue,
  tagValue,
  // selectedImage,
  required WidgetRef ref, // 추가: ref를 통해 상태 관리
  required double bottomPadding,
  required GlobalKey<FormState> formKey,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      bottom: bottomPadding,
    ),
    child: ElevatedButton(
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          Feed feed = Feed(
            id: 1,
            userId: "userId",
            userNickname: "userNickname",
            userImageUrl: "https://picsum.photos/seed/picsum/200/300",
            imageUrl: ["https://picsum.photos/seed/picsum/200/300"],
            tag: ["tag"],
            content: "content",
            createdAt: DateTime.now(),
            likeCnt: 1,
            isLike: true,
          );

          List<File> images = [];

          final writeNotifier = ref.read(writeViewModelProvider.notifier);
          writeNotifier.addFeed(feed, images);
        } else {
          print('폼이 유효하지 않음');
        }
        print(contentValue);
        print(tagValue);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Colors.black,
        elevation: 5, // 그림자 높이
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      child: const Text(
        '공유',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ), // 텍스트 스타일
      ),
    ),
  );
}
