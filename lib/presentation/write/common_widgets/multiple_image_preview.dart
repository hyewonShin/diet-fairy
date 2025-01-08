import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_manager/photo_manager.dart';

class MultipleImagePreview extends StatefulWidget {
  final List<AssetEntity> images;
  final AssetEntity? firstImage;
  final double screenHeight;

  const MultipleImagePreview(
      {required this.images,
      this.firstImage,
      required this.screenHeight,
      super.key});

  @override
  State<MultipleImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<MultipleImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight / 2.5,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.firstImage != null ? 1 : widget.images.length,
          itemBuilder: (context, index) {
            // FutureBuilder로 각 이미지 비동기적으로 로딩
            return FutureBuilder<File?>(
              future: widget.firstImage != null
                  ? widget.firstImage!.file
                  : widget.images[index].file,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 로딩 중일 때 로딩 애니메이션 표시
                  return Center(
                    child: Lottie.asset('assets/dot_loading.json',
                        width: 3, height: 3),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  // 이미지 파일이 로드되면 해당 파일을 표시
                  return Image.file(
                    snapshot.data!, // 비동기적으로 가져온 이미지 파일
                    fit: BoxFit.cover,
                  );
                } else {
                  // 이미지 로드에 실패했을 경우
                  return const Center(
                    child: Text('No Image Available'),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
