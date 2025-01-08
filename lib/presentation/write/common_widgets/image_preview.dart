import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePreview extends StatefulWidget {
  final AssetEntity image;
  final double screenHeight;

  const ImagePreview(
      {required this.image, required this.screenHeight, super.key});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: widget.image.file,
      // snapshot : Future의 상태 및 결과를 나타냄
      builder: (context, snapshot) {
        return Container(
          height: widget.screenHeight / 2.5,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: snapshot.connectionState == ConnectionState.waiting
              ? Lottie.asset('assets/dot_loading.json', width: 3, height: 3)
              : Image.file(
                  snapshot.data!,
                  fit: BoxFit.cover,
                ),
        );
      },
    );
  }
}
