import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/data_source/feed_data_source.dart';
import 'package:diet_fairy/data/dto/feed_dto.dart';
import 'package:diet_fairy/domain/entity/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FeedDataSourceImpl implements FeedDataSource {
  FeedDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  late final _collection = _firestore.collection('Feed');

  @override
  Future<List<FeedDto>?> getFeeds() async {
    try {
      // 생성일 기준으로 최신순으로 5개만 가져온다
      final result = await _collection
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();
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
  Future<List<FeedDto>?> getMoreFeeds(DateTime feedCreatedAt) async {
    try {
      // 마지막 게시물 id 기준 최신순으로 5개 가져온다
      final result = await _collection
          .where('createdAt', isLessThan: feedCreatedAt)
          .orderBy('createdAt', descending: true)
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
  Future<void> addFeed(
    User user,
    String content,
    List<String> tag,
    List<String> images,
  ) async {
    try {
      // 1. 이미지 파일을 Firebase Storage에 업로드하고 URL을 가져옴
      List<String> uploadedImageUrls = [];

      for (var imagePath in images) {
        // 1.1 파일 경로(String)를 File 객체로 변환
        File imageFile = File(imagePath);

        // 1.2 이미지 파일명을 고유하게 설정
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef =
            FirebaseStorage.instance.ref().child('feed/$imageName');

        try {
          // 1.3 이미지 업로드
          UploadTask uploadTask = storageRef.putFile(imageFile);
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

          // 1.4 업로드 완료 후 URL 가져오기
          String imageUrl = await taskSnapshot.ref.getDownloadURL();
          uploadedImageUrls.add(imageUrl);
        } catch (e) {
          print('이미지 업로드 중 오류 발생: $e');
        }
      }
      print('업로드된 이미지 URLs: $uploadedImageUrls');

      // 2.1 Feed의 고유한 id 가져오기
      final feedValue = await _collection.add({'userid': user.userId});
      final feedId = feedValue.id;

      // 2.2 firebase에 저장할 DTO 데이터 생성
      final newFeed = FeedDto(
        id: feedId,
        userId: user.userId,
        userNickname: user.nickname,
        userImageUrl: user.imageUrl,
        imageUrl: uploadedImageUrls,
        tag: tag,
        content: content,
        createdAt: DateTime.now(),
        likeCnt: 0,
        isLike: false,
      );

      // 2.3 Feed 객체를 Firestore에 저장
      await _firestore.collection('Feed').doc(feedId).set(newFeed.toJson());
      print("Feed uploaded successfully!");
    } catch (e) {
      print('FeedDataSourceImpl addFeeds error => $e');
      return null;
    }
  }
}
