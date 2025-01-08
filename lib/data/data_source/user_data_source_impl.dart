import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/data_source/user_data_source.dart';
import 'package:diet_fairy/data/dto/user_dto.dart';

class UserDataSourceImpl implements UserDataSource {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUser(String userId, String nickname) async {
    final collectionRef = _firestore.collection('User');

    final doc = collectionRef.doc(userId);

    doc.set({
      'nickname': nickname,
      'imageUrl': null,
      'feedCreatedAt': [],
      'weight': null,
      'desiredWeight': null,
      'likeFeed': [],
    });
  }

  @override
  Future<UserDto> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
