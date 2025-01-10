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
      GestureDetector(
          onTap: () {
            changeMultiImageFlag();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: photoLibraryIcon(multiImageFlag: multiImageFlag),
          )),
    ],
  );
}
