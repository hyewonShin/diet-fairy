import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diet_fairy/presentation/write/write_page.dart';
import 'package:photo_manager/photo_manager.dart';

AppBar writePageAppbar({
  required BuildContext context,
  required bool appBarFlag,
  bool multiImageFlag = false,
  bool isPerson = false,
  AssetEntity? selectedImage,
  List<AssetEntity>? selectedImages,
  dynamic contentController,
  dynamic tagController,
}) {
  return AppBar(
    title: const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "새 게시물",
      ),
    ),
    leading: IconButton(
      onPressed: () {
        if (appBarFlag) {
          Navigator.pop(context);
        } else {
          if (contentController.text.isEmpty && tagController.text.isEmpty) {
            Navigator.pop(context);
          } else {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text(
                      '작성 중인 내용이 저장되지 않았습니다. \n 정말로 나가시겠습니까?',
                      style: TextStyle(fontSize: 15),
                    ),
                    actions: [
                      CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('확인')),
                      CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('취소'))
                    ],
                  );
                });
          }
        }
      },
      icon: Icon(
        appBarFlag ? Icons.close : Icons.arrow_back,
        size: 40, // 아이콘 크기
      ),
      constraints: const BoxConstraints(
        minWidth: 50, // 가로 크기
        minHeight: 50, // 세로 크기
      ),
    ),
    actions: [
      appBarFlag
          ? GestureDetector(
              onTap: () {
                if (isPerson) {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text(
                            '사람이 포함된 이미지는 \n 업로드할 수 없습니다.',
                            style: TextStyle(fontSize: 15),
                          ),
                          content: const Text('다른 이미지를 선택해 주세요.'),
                          actions: [
                            CupertinoDialogAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('확인'))
                          ],
                        );
                      });
                } else {
                  if ((selectedImage == null) &&
                      (selectedImages == null || selectedImages.isEmpty)) {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('이미지를 선택해주세요.'),
                            content: const Text('업로드할 이미지를 선택한 후 진행해주세요.'),
                            actions: [
                              CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('확인'))
                            ],
                          );
                        });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WritePage(
                            multiImageFlag: multiImageFlag,
                            selectedImage: selectedImage,
                            selectedImages: selectedImages),
                      ),
                    );
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: Text(
                  "다음",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            )
          : const SizedBox.shrink()
    ],
  );
}
