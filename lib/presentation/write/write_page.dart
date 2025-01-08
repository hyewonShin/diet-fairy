import 'package:diet_fairy/presentation/write/write_page_widgets/bottom_btn.dart';
import 'package:diet_fairy/presentation/write/write_page_widgets/contents_box.dart';
import 'package:diet_fairy/presentation/write/common_widgets/img_container.dart';
import 'package:diet_fairy/presentation/write/common_widgets/write_page_appbar.dart';
import 'package:diet_fairy/presentation/write/write_page_widgets/tag_box.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

// Feed 엔티티 사용하여 데이터 맞춰서 firebase에 전송 해주기
class WritePage extends StatefulWidget {
  final AssetEntity? selectedImage;
  final List<AssetEntity>? selectedImages;
  final bool multiImageFlag;

  const WritePage(
      {required this.multiImageFlag,
      this.selectedImage,
      this.selectedImages,
      super.key});

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
    // 화면의 전체 높이 가져오기
    final double screenHeight = MediaQuery.of(context).size.height;
    // 하단 버튼 padding
    final bottomPadding =
        MediaQuery.of(context).size.height > 600 ? 40.0 : 24.0;

    return Scaffold(
      appBar: writePageAppbar(
        context: context,
        appBarFlag: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: imgContainer(
                  multiImageFlag: widget.multiImageFlag,
                  selectedImage: widget.selectedImage,
                  selectedImages: widget.selectedImages,
                  screenHeight: screenHeight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  contentsBox(
                      contentController: _contentController,
                      screenHeight: screenHeight),
                  tagBox(_tagController),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBtn(
          context: context,
          contentController: _contentController,
          tagController: _tagController,
          bottomPadding: bottomPadding),
    );
  }
}
