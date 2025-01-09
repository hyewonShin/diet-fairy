import 'package:diet_fairy/presentation/write/write_img_upload_widgets/camera_icon.dart.dart';
import 'package:diet_fairy/presentation/write/write_img_upload_widgets/photo_library_icon.dart';
import 'package:flutter/material.dart';

Widget header({required changeMultiImageFlag, required multiImageFlag}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Recent',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 40,
          ),
        ],
      ),
      Row(
        children: [
          GestureDetector(
              onTap: () {
                changeMultiImageFlag();
              },
              child: photoLibraryIcon(multiImageFlag: multiImageFlag)),
          const SizedBox(
            width: 3,
          ),
          GestureDetector(
              onTap: () {
                // 카메라 촬영
              },
              child: cameraIcon()),
        ],
      ),
    ],
  );
}
