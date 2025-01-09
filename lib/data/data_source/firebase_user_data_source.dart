import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:diet_fairy/data/dto/user_dto.dart';
import 'dart:io';

class FirebaseUserDataSource {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<UserDto?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return null;

    final data = doc.data()!;
    data['id'] = doc.id;
    return UserDto.fromJson(data);
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
