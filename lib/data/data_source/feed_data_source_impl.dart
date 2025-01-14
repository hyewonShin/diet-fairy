import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/data_source/feed_data_source.dart';
import 'package:diet_fairy/data/dto/feed_dto.dart';
import 'package:diet_fairy/domain/entity/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

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
      // 2.1 Feed의 고유한 id 생성
      String formattedDate =
          DateFormat('yyyyMMddHHmmssSSS').format(DateTime.now());

      // 2.2 firebase에 저장할 DTO 데이터 생성
      final newFeed = FeedDto(
        id: formattedDate.toString(),
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
      await _firestore.collection('Feed').add(newFeed.toJson());
      print("Feed uploaded successfully!");
    } catch (e) {
      print('FeedDataSourceImpl addFeeds error => $e');
      return null;
    }
  }

  @override
  Future<void> deleteFeed(String feedId) async {
    try {
      // 1. Firestore에서 해당 feedId로 문서를 조회
      final snapshot = await _collection.where('id', isEqualTo: feedId).get();

      if (snapshot.docs.isNotEmpty) {
        // 2. 문서 데이터를 가져오기
        final doc = snapshot.docs.first;
        final data = doc.data();

        // 3. 문서에 저장된 이미지 URL 리스트 가져오기
        if (data.containsKey('imageUrl') && data['imageUrl'] is List) {
          List<String> imageUrls = List<String>.from(data['imageUrl']);

          // 4. 각 URL에 해당하는 Storage 파일 삭제
          for (var imageUrl in imageUrls) {
            try {
              Reference storageRef =
                  FirebaseStorage.instance.refFromURL(imageUrl);
              await storageRef.delete();
              print('✅ Storage file deleted: $imageUrl');
            } catch (e) {
              print('❌ Error deleting file from storage: $e');
              if (e is FirebaseException) {
                print('Error code: ${e.code}, message: ${e.message}');
              }
            }
          }
        }

        // 5. Firestore에서 문서 삭제
        await doc.reference.delete();
        print('Document deleted successfully');
      } else {
        print('No document found with feedId: $feedId');
      }
    } catch (e) {
      print('FeedDataSourceImpl deleteFeed error => $e');
    }
  }
}
