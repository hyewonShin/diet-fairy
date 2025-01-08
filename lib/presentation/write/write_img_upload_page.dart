import 'dart:io';
import 'package:diet_fairy/presentation/write/common_widgets/img_container.dart';
import 'package:diet_fairy/presentation/write/write_img_upload_widgets/header.dart';
import 'package:diet_fairy/presentation/write/common_widgets/write_page_appbar.dart';
import 'package:diet_fairy/presentation/write/write_img_upload_widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<AssetEntity> images = [];
  List<AssetEntity> selectedImages = [];
  AssetEntity? selectedImage;
  bool multiImageFlag = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  // 권한 요청 후 갤러리 접근
  void checkPermission() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      // 권한이 승인되면 갤러리의 이미지를 가져옵니다.
      fetchGalleryImages();
    } else {
      PhotoManager.openSetting(); // 권한 설정 열기
    }
  }

  // 갤러리 이미지 리스트 가져오기
  void fetchGalleryImages() async {
    // 첫 번째 앨범을 가져오기
    final list = await PhotoManager.getAssetPathList(type: RequestType.image);

    // 첫 번째 앨범에서 첫 페이지 100개의 이미지를 가져옴
    final assets =
        await list[0].getAssetListPaged(page: 0, size: 100); // 페이지 번호와 크기 명시
    setState(() {
      images = assets;
    });
  }

  // 단일 이미지 선택
  void selectImage(AssetEntity asset) async {
    final file = await asset.file;
    if (file != null) {
      setState(() {
        selectedImage = asset;
      });
    }
    print('selectedImage > $selectedImage');
  }

  //  다중 이미지 선택
  void selectImages(AssetEntity asset) async {
    final file = await asset.file;
    if (file != null) {
      setState(() {
        selectedImages.add(asset); // 이미지를 선택 목록에 추가
      });
      print('selectedImages > $selectedImages');
    }
  }

  //  다중 이미지 선택 플래그 전환
  void changeMultiImageFlag() async {
    setState(() {
      multiImageFlag = !multiImageFlag;
    });
    print('💕 multiImageFlag > $multiImageFlag');
  }

  @override
  Widget build(BuildContext context) {
    // 화면의 전체 높이 가져오기
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: writePageAppbar(
          context: context,
          appBarFlag: true,
          multiImageFlag: multiImageFlag,
          selectedImage: selectedImage,
          selectedImages: selectedImages),
      body: Column(
        children: [
          // 이미지 미리보기
          imgContainer(
            images: images,
            multiImageFlag: multiImageFlag,
            selectedImage: selectedImage,
            selectedImages: selectedImages,
            screenHeight: screenHeight,
          ),
          // header(), //TODO 다시 header로
          Row(
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
                  GestureDetector(
                      onTap: () {
                        changeMultiImageFlag();
                      },
                      child: icon(camera: true)),
                  icon(),
                ],
              ),
            ],
          ),
          // 이미지 리스트
          Expanded(
              child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final asset = images[index];
              return GestureDetector(
                onTap: () {
                  multiImageFlag ? selectImages(asset) : selectImage(asset);
                },
                child: FutureBuilder<File?>(
                  future: asset.file, // 파일을 가져옴
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Lottie.asset('assets/loading.json');
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      return Image.file(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      );
                    }
                    // FutureBuilder에서 파일이 없거나 snapshot.data가 null일 때 아무런 UI를 표시하지 않도록 설정
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
