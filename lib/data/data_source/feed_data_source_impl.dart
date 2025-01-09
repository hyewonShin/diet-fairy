import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/data_source/feed_data_source.dart';
import 'package:diet_fairy/data/dto/feed_dto.dart';

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
}
