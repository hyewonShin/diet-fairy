import 'dart:io';
import 'package:diet_fairy/presentation/write/common_widgets/img_container.dart';
import 'package:diet_fairy/presentation/write/upload_controller.dart';
import 'package:diet_fairy/presentation/write/write_img_upload_widgets/header.dart';
import 'package:diet_fairy/presentation/write/common_widgets/write_page_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadController controller = Get.put(UploadController());
    controller.checkPermission(); // 권한 요청 및 갤러리 이미지 불러오기

    // 화면의 전체 높이 가져오기
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: writePageAppbar(
          context: context,
          appBarFlag: true,
          image: controller.selectedImage.value),
      body: Column(
        children: [
          // 이미지 미리보기
          imgContainer(controller, screenHeight),
          header(),
          // 이미지 리스트
          Expanded(
            child: Obx(() {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: controller.images.value.length,
                itemBuilder: (context, index) {
                  final asset = controller.images.value[index];
                  return GestureDetector(
                    onTap: () {
                      controller.selectImage(asset); // 이미지를 선택
                    },
                    child: FutureBuilder<File?>(
                      future: asset.file, // 파일을 가져옴
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasData && snapshot.data != null) {
                          return Image.file(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
                        }
                        // FutureBuilder에서 파일이 없거나 snapshot.data가 null일 때 아무런 UI를 표시하지 않도록 설정
                        return const SizedBox.shrink();
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
