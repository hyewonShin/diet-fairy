import 'dart:io';
import 'package:image/image.dart' as img;

class ImageCompressor {
  static Future<File> compressImage(File file) async {
    // 원본 이미지 파일 읽기
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) return file;

    // 이미지 크기 조정 (최대 너비 1024px로 제한)
    int targetWidth = 1024;
    int targetHeight = (targetWidth * image.height / image.width).round();

    // 이미지 리사이즈 및 품질 압축
    final resizedImage = img.copyResize(
      image,
      width: targetWidth,
      height: targetHeight,
      interpolation: img.Interpolation.linear,
    );

    // JPEG 포맷으로 압축 (품질: 70%)
    final compressedBytes = img.encodeJpg(resizedImage, quality: 70);

    // 압축된 이미지를 임시 파일로 저장
    final tempPath = Directory.systemTemp.path;
    final tempFile = File(
        '$tempPath/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await tempFile.writeAsBytes(compressedBytes);

    return tempFile;
  }

  static Future<File> compressProfileImage(File file) async {
    // 프로필 이미지는 더 작은 크기로 압축
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) return file;

    // 프로필 이미지는 500x500으로 제한
    int targetSize = 500;
    final resizedImage = img.copyResize(
      image,
      width: targetSize,
      height: targetSize,
      interpolation: img.Interpolation.linear,
    );

    // JPEG 포맷으로 압축 (품질: 80%)
    final compressedBytes = img.encodeJpg(resizedImage, quality: 80);

    // 압축된 이미지를 임시 파일로 저장
    final tempPath = Directory.systemTemp.path;
    final tempFile = File(
        '$tempPath/compressed_profile_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await tempFile.writeAsBytes(compressedBytes);

    return tempFile;
  }
}
