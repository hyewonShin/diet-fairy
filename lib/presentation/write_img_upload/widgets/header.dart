import 'package:diet_fairy/presentation/write_img_upload/widgets/icons.dart';
import 'package:flutter/material.dart';

Widget header() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
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
          icon(true),
          icon(false),
        ],
      ),
    ],
  );
}
