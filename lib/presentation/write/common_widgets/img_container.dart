import 'package:diet_fairy/presentation/write/upload_controller.dart';
import 'package:diet_fairy/presentation/write/common_widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Obx imgContainer(
    {required UploadController controller, required double screenHeight}) {
  return Obx(() {
    // selectedImage가 null이 아닌 경우(특정 이미지 선택한 경우)
    if (controller.selectedImage.value != null) {
      return ImagePreview(
        image: controller.selectedImage.value,
        screenHeight: screenHeight,
      );
    } else if (controller.images.value.isNotEmpty) {
      // 특정 이미지 선택 전, 앨범 이미지(images)가 비어 있지 않은 경우 첫 번째 이미지 표시
      return ImagePreview(
        image: controller.images.value[0],
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
  });
}
