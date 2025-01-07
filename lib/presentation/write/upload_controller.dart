import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadController extends GetxController {
  final Rx<AssetEntity?> selectedImage = Rx<AssetEntity?>(null);
  final Rx<List<AssetEntity>> images = Rx<List<AssetEntity>>([]);

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
    images.value = assets;
  }

  // 이미지 선택
  void selectImage(AssetEntity asset) {
    selectedImage.value = asset;
  }
}
