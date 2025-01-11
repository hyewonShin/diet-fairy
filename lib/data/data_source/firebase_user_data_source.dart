import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/dto/user_dto.dart';
import 'package:diet_fairy/domain/data_source/user_data_source.dart';

class FirebaseUserDataSource implements UserDataSource {
  @override
  Future<void> createUser(String userId, String nickname) async {
    await FirebaseFirestore.instance.collection('user').doc(userId).set({
      'userId': userId,
      'nickname': nickname,
      'weight': 0,
      'desiredWeight': 0,
      'imageUrl': null,
      'feedCreatedAt': [],
      'likeFeed': [],
    });
  }

  @override
  Future<UserDto?> getUser(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();

    if (doc.exists) {
      return UserDto.fromJson(doc.data()!);
    }
    return null;
  }
}
