import 'package:diet_fairy/presentation/write/common_widgets/image_preview.dart';
import 'package:diet_fairy/presentation/write/common_widgets/multiple_image_preview.dart';
import 'package:flutter/material.dart';

Widget imgContainer({
  required bool multiImageFlag,
  required double screenHeight,
  images,
  selectedImage,
  selectedImages,
}) {
  // 다중 선택
  if (multiImageFlag) {
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // 특정 이미지를 선택한 경우
      return MultipleImagePreview(
        images: selectedImages,
        screenHeight: screenHeight,
      );
    } else {
      // 특정 이미지를 선택하지 않은 경우
      return MultipleImagePreview(
        images: images,
        firstImage: images.isNotEmpty ? images[0] : null,
        screenHeight: screenHeight,
      );
    }
  }

  // 단일 선택
  if (selectedImage != null) {
    // 특정 이미지를 선택한 경우
    return ImagePreview(
      image: selectedImage,
      screenHeight: screenHeight,
    );
  } else if (images.isNotEmpty) {
    // 특정 이미지를 선택하지 않은 경우, 첫 번째 이미지를 미리보기
    return ImagePreview(
      image: images[0],
      screenHeight: screenHeight,
    );
  }

  return Container(
    height: screenHeight / 2.5,
    width: double.infinity,
    decoration: const BoxDecoration(color: Colors.white),
    child: const Center(
      child: Text('이미지가 없습니다'),
    ),
  );
}
