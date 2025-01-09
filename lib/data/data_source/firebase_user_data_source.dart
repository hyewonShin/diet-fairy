import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:diet_fairy/data/dto/user_dto.dart';
import 'dart:io';

class FirebaseUserDataSource {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<UserDto?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();

      if (!doc.exists) {
        print('User document does not exist');
        // 새 사용자 생성
        final newUser = UserDto(
          userId: userId,
          nickname: '새로운 사용자',
          imageUrl: null,
          feedCreatedAt: [],
          weight: 0,
          desiredWeight: 0,
          likeFeed: [],
        );
        await createUser(newUser);
        return newUser;
      }

      final data = doc.data()!;
      data['userId'] = doc.id; // id 대신 userId 사용
      return UserDto.fromJson(data);
    } catch (e, stackTrace) {
      print('Error getting user: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<void> updateUser(UserDto user) async {
    await _firestore.collection('users').doc(user.userId).update(user.toJson());
  }

  Future<String> uploadProfileImage(String userId, String imagePath) async {
    final ref = _storage.ref().child('profiles/$userId.jpg');
    await ref.putFile(File(imagePath));
    return await ref.getDownloadURL();
  }

  Future<void> createUser(UserDto user) async {
    await _firestore.collection('users').doc(user.userId).set(user.toJson());
  }
}
