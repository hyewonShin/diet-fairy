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
      final result = await _collection.get();
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
}
