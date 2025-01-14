import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/presentation/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:diet_fairy/util/image_compressor.dart';

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
            .collection('user')
            .doc(result.user!.userId)
            .get();

        if (userDoc.exists) {
          // 저장된 정보 가져오기
          final weight = userDoc.data()?['weight'] as int? ?? 0;
          final desiredWeight = userDoc.data()?['desiredWeight'] as int? ?? 0;
          final nickname = userDoc.data()?['nickname'] as String?;

          // 사용자 정보 업데이트
          state = result.user!.copyWith(
            weight: weight,
            desiredWeight: desiredWeight,
            imageUrl: userDoc.data()?['imageUrl'] as String?,
            nickname: nickname ?? result.user!.nickname,
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
      print('Updating user in Firebase - userId: ${user.userId}');
      final userRef =
          FirebaseFirestore.instance.collection('user').doc(user.userId);

      final updateData = {
        'nickname': user.nickname,
        'weight': user.weight,
        'desiredWeight': user.desiredWeight,
        'imageUrl': user.imageUrl,
      };
      print('Update data: $updateData');

      // 문서가 존재하는지 먼저 확인
      final docSnapshot = await userRef.get();
      if (!docSnapshot.exists) {
        print('Document does not exist, creating new document');
        await userRef.set(updateData);
      } else {
        print('Document exists, updating');
        await userRef.update(updateData);
      }

      // 업데이트 후 데이터 확인
      final updatedDoc = await userRef.get();
      print('Updated document data: ${updatedDoc.data()}');

      // 로컬 상태 업데이트
      state = user;
      print('User updated successfully in Firebase and local state');
    } catch (e, stackTrace) {
      print('Error updating user: $e');
      print('Stack trace: $stackTrace');
      // Firebase 오류 상세 정보 출력
      if (e is FirebaseException) {
        print('Firebase error code: ${e.code}');
        print('Firebase error message: ${e.message}');
      }
    }
  }

  Future<void> updateProfileImage(String userId, String imagePath) async {
    try {
      print('Updating profile image - userId: $userId');
      final file = File(imagePath);
      if (!file.existsSync()) {
        print('Image file not found at path: $imagePath');
        return;
      }

      // 이미지 압축
      final compressedFile = await ImageCompressor.compressProfileImage(file);
      print('Image compressed: ${await compressedFile.length()} bytes');

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$userId.jpg');

      // 압축된 파일 업로드
      await storageRef.putFile(compressedFile);
      final imageUrl = await storageRef.getDownloadURL();
      print('Image uploaded, URL: $imageUrl');

      // Firestore 업데이트
      final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
      await userRef.update({
        'imageUrl': imageUrl,
      });
      print('Image URL updated in Firestore');

      // 로컬 상태 업데이트
      if (state != null) {
        state = state!.copyWith(imageUrl: imageUrl);
        print('Local state updated with new image URL');
      }
    } catch (e) {
      print('Error updating profile image: $e');
    }
  }

  Future<void> updateWeight(User user) async {
    try {
      print('Updating weight in Firebase - userId: ${user.userId}');
      final userRef =
          FirebaseFirestore.instance.collection('user').doc(user.userId);

      final updateData = {
        'weight': user.weight,
        'desiredWeight': user.desiredWeight,
      };
      print('Weight update data: $updateData');

      // 문서가 존재하는지 먼저 확인
      final docSnapshot = await userRef.get();
      if (!docSnapshot.exists) {
        print('Document does not exist, creating new document');
        await userRef.set(updateData);
      } else {
        print('Document exists, updating');
        await userRef.update(updateData);
      }

      // 업데이트 후 데이터 확인
      final updatedDoc = await userRef.get();
      print('Updated document data: ${updatedDoc.data()}');

      // 로컬 상태 업데이트
      state = user;
      print('Weight updated successfully in Firebase');
    } catch (e) {
      print('Error updating weight: $e');
      if (e is FirebaseException) {
        print('Firebase error code: ${e.code}');
        print('Firebase error message: ${e.message}');
      }
    }
  }
}

final userGlobalViewModelProvider =
    NotifierProvider<UserGlobalViewModel, User?>(
  () {
    return UserGlobalViewModel();
  },
);
