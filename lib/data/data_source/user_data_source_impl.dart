import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/data_source/user_data_source.dart';
import 'package:diet_fairy/data/dto/user_dto.dart';

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  late final _collection = _firestore.collection('User');

  @override
  Future<void> createUser(String userId, String nickname) async {
    try {
      _collection.doc(userId).set({
        'nickname': nickname,
        'imageUrl': '',
        'feedCreatedAt': [],
        'weight': 0,
        'desiredWeight': 0,
        'likeFeed': [],
      });
    } catch (e) {
      print('UserDataSourceImpl createUser error: $e');
    }
  }

  @override
  Future<UserDto?> getUser(String userId) async {
    try {
      return await _collection.doc(userId).get().then((doc) {
        final map = doc.data();

        if (map != null) {
          // userId 설정
          map['userId'] = userId;
          return UserDto.fromJson(map);
        } else {
          return null;
        }
      }, onError: (e) => print('getUser error: $e'));
    } catch (e) {
      print('getUser error: $e');
    }
    return null;
  }
}
