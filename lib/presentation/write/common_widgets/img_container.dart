import 'package:diet_fairy/presentation/write/common_widgets/image_preview.dart';
import 'package:diet_fairy/presentation/write/common_widgets/multiple_image_preview.dart';
import 'package:flutter/material.dart';

Widget imgContainer(
    {required multiImageFlag,
    images,
    selectedImage,
    selectedImages,
    required double screenHeight}) {
  if (multiImageFlag) {
    // 다중 선택 아이콘 클린한 경우
    return MultipleImagePreview(
        images: selectedImages, screenHeight: screenHeight);
  } else if (selectedImage != null) {
    // selectedImage가 null이 아닌 경우(특정 이미지 선택한 경우)
    return ImagePreview(
      image: selectedImage,
      screenHeight: screenHeight,
    );
  } else if (images != null && images.isNotEmpty) {
    // 특정 이미지 선택 전, 앨범 이미지(images)가 비어 있지 않은 경우 첫 번째 이미지 표시
    return ImagePreview(
      image: images[0],
      screenHeight: screenHeight,
    );
  } else {
    // 앨범 이미지(images)가 없을 경우 텍스트 표시
    return Container(
      height: screenHeight / 2.5,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Text('이미지가 없습니다'),
      ),
    );
  }
}
