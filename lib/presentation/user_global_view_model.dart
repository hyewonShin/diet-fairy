import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserGlobalViewModel extends Notifier<User?> {
  @override
  User? build() {
    return null;
  }

  Future<String?> join({
    required String email,
    required String nickname,
    required String password,
  }) async {
    final joinUsecase = ref.read(joinUsecaseProvider);
    final result = await joinUsecase.join(
      email: email,
      nickname: nickname,
      password: password,
    );
    return result;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginUsecase = ref.read(loginUsecaseProvider);
      final result = await loginUsecase.login(email, password);

      // 로그인 성공
      if (result.failResult == null && result.user != null) {
        // Firestore에서 최신 사용자 정보 가져오기
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.userId)
            .get();

        if (userDoc.exists) {
          // 저장된 체중 정보 가져오기
          final weight = userDoc.data()?['weight'] as int? ?? 0;
          final desiredWeight = userDoc.data()?['desiredWeight'] as int? ?? 0;

          // 사용자 정보 업데이트
          state = result.user!.copyWith(
            weight: weight,
            desiredWeight: desiredWeight,
            imageUrl: userDoc.data()?['imageUrl'] as String?,
          );
        } else {
          state = result.user;
        }
      }

      return result.failResult;
    } catch (e) {
      print('Error during login: $e');
      return '로그인 중 오류가 발생했습니다.';
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.userId);

      // Firestore 업데이트
      await userRef.update({
        'weight': user.weight,
        'desiredWeight': user.desiredWeight,
        'imageUrl': user.imageUrl,
      });

      // 로컬 상태 업데이트
      state = user;
      print(
          'User updated successfully - weight: ${user.weight}, desired: ${user.desiredWeight}');
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> updateProfileImage(String userId, String imagePath) async {
    try {
      // Firebase Storage에 이미지 업로드
      final file = File(imagePath);
      if (!file.existsSync()) {
        print('Image file not found');
        return;
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$userId.jpg');

      // 메타데이터 설정
      final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': imagePath});

      // 파일 업로드
      await storageRef.putFile(file, metadata);
      final imageUrl = await storageRef.getDownloadURL();

      // Firestore 사용자 문서 업데이트
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'imageUrl': imageUrl});

      // 로컬 상태 업데이트
      if (state != null) {
        state = state!.copyWith(imageUrl: imageUrl);
      }
    } catch (e) {
      print('Error updating profile image: $e');
    }
  }
}

final userGlobalViewModelProvider =
    NotifierProvider<UserGlobalViewModel, User?>(
  () {
    return UserGlobalViewModel();
  },
);
