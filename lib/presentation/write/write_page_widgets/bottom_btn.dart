import 'package:diet_fairy/presentation/home/home_page.dart';
import 'package:diet_fairy/presentation/home/home_view_model.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:diet_fairy/presentation/write/write_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

Widget bottomBtn({
  required context,
  required TextEditingController contentController,
  required TextEditingController tagController,
  required List<String> tags, // 태그 리스트 추가
  AssetEntity? selectedImage,
  List<AssetEntity>? selectedImages,
  required WidgetRef ref, // 추가: ref를 통해 상태 관리
  required double bottomPadding,
  required GlobalKey<FormState> formKey,
}) {
  void submitValue(imagePaths) async {
    try {
      // 데이터 삽입 작업 완료까지 대기
      await ref.read(writeViewModelProvider.notifier).addFeed(
            contentController.text,
            tags,
            imagePaths.toSet().toList(),
          );

      // 삽입 작업이 성공적으로 완료되면 컨트롤러 초기화
      contentController.clear();
      tagController.clear();

      // 홈 피드 게시물 불러오기
      await ref.read(homeViewModelProvider.notifier).fetch();

      final user = ref.read(userGlobalViewModelProvider);

      // 홈 화면으로 이동
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user!),
        ),
        (route) => false, // 뒤로가기 스택을 모두 제거
      );
    } catch (e) {
      print('데이터 삽입 중 오류 발생: $e');
    }
  }

  return Padding(
    padding: EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      bottom: bottomPadding,
    ),
    child: ElevatedButton(
      onPressed: () async {
        if (formKey.currentState?.validate() == true) {
          List<String> imagePaths = [];

          if (selectedImage != null) {
            final file = await selectedImage.file;
            if (file != null) {
              imagePaths.add(file.path);
            }
          }
          for (final asset in selectedImages ?? []) {
            final file = await asset.file;
            if (file != null) {
              imagePaths.add(file.path);
            }
          }
          submitValue(imagePaths);
        } else {
          print('폼이 유효하지 않음');
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Colors.black,
        elevation: 5, // 그림자 높이
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      child: const Text(
        '공유',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ), // 텍스트 스타일
      ),
    ),
  );
}
