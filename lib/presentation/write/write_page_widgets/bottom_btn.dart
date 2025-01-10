import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:diet_fairy/presentation/write/write_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

Widget bottomBtn({
  required context,
  required String contentValue,
  required List<String> tagValue,
  AssetEntity? selectedImage,
  List<AssetEntity>? selectedImages,
  required WidgetRef ref, // 추가: ref를 통해 상태 관리
  required double bottomPadding,
  required GlobalKey<FormState> formKey,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      bottom: bottomPadding,
    ),
    child: ElevatedButton(
      onPressed: () async {
        if (formKey.currentState?.validate() ?? false) {
          List<String> imagePaths = [];

          // 단일 이미지 AssetEntity -> List<String> 변환
          if (selectedImage != null) {
            final file = await selectedImage.file;
            if (file != null) {
              imagePaths.add(file.path); // 파일 경로 추출
            }
          }

          // 다중 이미지 AssetEntity -> List<String> 변환
          for (final asset in selectedImages ?? []) {
            final file = await asset.file;
            if (file != null) {
              imagePaths.add(file.path); // 파일 경로 추출
            }
          }

          ref
              .read(
                writeViewModelProvider.notifier,
              )
              .addFeed(
                contentValue,
                tagValue,
                imagePaths,
              );
        } else {
          print('폼이 유효하지 않음');
        }
      },
      style: ElevatedButton.styleFrom(
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
