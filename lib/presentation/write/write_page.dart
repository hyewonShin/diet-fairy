import 'package:diet_fairy/presentation/write/write_page_widgets/bottom_btn.dart';
import 'package:diet_fairy/presentation/write/write_page_widgets/contents_box.dart';
import 'package:diet_fairy/presentation/write/common_widgets/img_container.dart';
import 'package:diet_fairy/presentation/write/common_widgets/write_page_appbar.dart';
import 'package:diet_fairy/presentation/write/write_page_widgets/tag_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

class WritePage extends ConsumerStatefulWidget {
  final AssetEntity? selectedImage;
  final List<AssetEntity>? selectedImages;
  final bool multiImageFlag;

  const WritePage(
      {required this.multiImageFlag,
      this.selectedImage,
      this.selectedImages,
      super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final contentController = TextEditingController();
  final tagController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    contentController.dispose();
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면의 전체 높이 가져오기
    final double screenHeight = MediaQuery.of(context).size.height;
    // 하단 버튼 padding
    final bottomPadding =
        MediaQuery.of(context).size.height > 600 ? 40.0 : 24.0;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: writePageAppbar(
          context: context,
          appBarFlag: false,
          contentController: contentController,
          tagController: tagController,
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ContentsBox(
                          contentController: contentController,
                          screenHeight: screenHeight),
                      tagBox(tagController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomBtn(
          context: context,
          ref: ref,
          // selectedImage: widget.selectedImage,
          contentValue: contentController.text,
          tagValue: tagController.text,
          bottomPadding: bottomPadding,
          formKey: _formKey,
        ),
      ),
    );
  }
}
