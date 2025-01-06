import 'package:diet_fairy/presentation/write/widgets/bottom_btn.dart';
import 'package:diet_fairy/presentation/write/widgets/contents_box.dart';
import 'package:diet_fairy/presentation/write/widgets/img_container.dart';
import 'package:diet_fairy/presentation/write_img_upload/upload_controller.dart';
import 'package:diet_fairy/presentation/write_img_upload/widgets/img_upload_appbar.dart';
import 'package:diet_fairy/presentation/write/widgets/tag_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_manager/photo_manager.dart';

class WritePage extends StatefulWidget {
  final AssetEntity? image;

  const WritePage({required this.image, super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final _contentController = TextEditingController();
  final _tagController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UploadController controller = Get.put(UploadController());
    // 화면의 전체 높이 가져오기
    final double screenHeight = MediaQuery.of(context).size.height;
    // 하단 버튼 padding
    final bottomPadding =
        MediaQuery.of(context).size.height > 600 ? 40.0 : 24.0;

    return Scaffold(
      appBar: writePageAppbar(true, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imgContainer(controller, screenHeight),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  contentsBox(_contentController, screenHeight),
                  tagBox(_tagController),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          bottomBtn(_contentController, _tagController, bottomPadding),
    );
  }
}
