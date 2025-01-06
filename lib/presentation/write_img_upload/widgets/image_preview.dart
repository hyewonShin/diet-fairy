import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePreview extends StatelessWidget {
  final AssetEntity image;
  final double screenHeight;

  const ImagePreview(
      {required this.image, required this.screenHeight, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: image.file,
      builder: (context, snapshot) {
        return Container(
          height: screenHeight / 2,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : Image.file(
                  snapshot.data!,
                  fit: BoxFit.cover,
                ),
        );
      },
    );
  }
}
