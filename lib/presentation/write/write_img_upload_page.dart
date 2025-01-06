import 'dart:io';

import 'package:diet_fairy/presentation/write/widgets/img_upload_appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WriteImgUploadPage extends StatefulWidget {
  const WriteImgUploadPage({super.key});

  @override
  State<WriteImgUploadPage> createState() => _WriteImgUploadPageState();
}

class _WriteImgUploadPageState extends State<WriteImgUploadPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  // 갤러리에서 이미지 선택
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 이미지 경로로 File 객체 생성
      });
    }
  }

  // 카메라로 이미지 촬영
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: imgUploadAppbar(context),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              _pickImageFromGallery();
            },
            child: SizedBox(
              height: screenHeight / 2.5,
              width: double.infinity,
              child: _image == null
                  ? const Text('이미지를 선택해주세요')
                  : Image.file(
                      _image!,
                      width: 300,
                      height: 300,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
