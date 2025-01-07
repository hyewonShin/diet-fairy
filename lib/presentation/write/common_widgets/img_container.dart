import 'package:diet_fairy/presentation/write/upload_controller.dart';
import 'package:diet_fairy/presentation/write/common_widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Obx imgContainer(UploadController controller, double screenHeight) {
  return Obx(() {
    return controller.selectedImage.value != null
        ? ImagePreview(
            image: controller.selectedImage.value!, screenHeight: screenHeight)
        : Container(
            height: screenHeight / 2.5,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: const Center(
              child: Text('이미지를 선택해주세요'),
            ),
          );
  });
}
