import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/data_source/feed_data_source.dart';
import 'package:diet_fairy/data/dto/feed_dto.dart';
import 'package:diet_fairy/domain/entity/feed.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FeedDataSourceImpl implements FeedDataSource {
  FeedDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  late final _collection = _firestore.collection('Feed');

  @override
  Future<List<FeedDto>?> getFeeds() async {
    try {
      // id 기준으로 내림차순하여 5개만 가져온다
      final result =
          await _collection.orderBy('id', descending: true).limit(5).get();
      return result.docs.map(
        (e) {
          return FeedDto.fromJson(e.data());
        },
      ).toList();
    } catch (e) {
      print('FeedDataSourceImpl getFeeds error => $e');
      return null;
    }
  }

  @override
  Future<List<FeedDto>?> getMoreFeeds(int feedId) async {
    try {
      // 마지막 게시물 id 기준 최신순으로 5개 가져온다
      final result = await _collection
          .where('id', isLessThan: feedId)
          .orderBy('id')
          .limit(5)
          .get();

      return result.docs.map((e) {
        return FeedDto.fromJson(e.data());
      }).toList();
    } catch (e) {
      print('FeedDataSourceImpl getMoreFeeds error => $e');
      return null;
    }
  }

  @override
  Future<void> addFeed(FeedDto feed, List<File> images) async {
    try {
      // 1. 이미지 파일을 Firebase Storage에 업로드하고 URL을 가져옴
      List<String> uploadedImageUrls = [];

      for (var image in images) {
        // 이미지 파일명을 고유하게 설정
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef =
            FirebaseStorage.instance.ref().child('feeds/$imageName');

        // 이미지 업로드
        UploadTask uploadTask = storageRef.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        // 업로드 완료 후 URL 가져오기
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        uploadedImageUrls.add(imageUrl);
      }

      // 2. Feed 객체를 Firestore에 저장
      CollectionReference feeds = FirebaseFirestore.instance.collection('Feed');

      // Firestore에 저장할 Feed 데이터를 FeedDto으로 변환
      FeedDto newFeed = FeedDto(
        id: feed.id,
        userId: feed.userId,
        userNickname: feed.userNickname,
        userImageUrl: feed.userImageUrl,
        imageUrl: uploadedImageUrls, // Cloud Storage에서 가져온 이미지 URL들
        tag: feed.tag,
        content: feed.content,
        createdAt: feed.createdAt,
        likeCnt: feed.likeCnt,
        isLike: feed.isLike,
      );

      // Firestore에 추가
      await feeds.add(newFeed.toJson());
      print("Feed uploaded successfully!");
    } catch (e) {
      print('FeedDataSourceImpl addFeeds error => $e');
      return null;
    }
  }
}
