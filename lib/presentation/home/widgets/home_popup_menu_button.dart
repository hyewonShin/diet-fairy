import 'package:diet_fairy/presentation/my/my_page.dart';
import 'package:diet_fairy/presentation/write/write_img_upload_page.dart';
import 'package:flutter/material.dart';

class HomePopupMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Widget>(
      // 메뉴 모양 지정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      // popup 아이콘 색상
      iconColor: Colors.white,
      // 팝업 메뉴 펼쳐지는 위치 설정
      position: PopupMenuPosition.under,
      // 팝업 메뉴바 색상
      color: Colors.white70,
      itemBuilder: (context) {
        return [
          _menuItem(Icons.person, '마이페이지', context, MyPage()),
          _menuItem(Icons.post_add, '게시글 작성', context, UploadPage()),
        ];
      },
    );
  }

  PopupMenuItem<Widget> _menuItem(
    IconData icon,
    String text,
    BuildContext context,
    dynamic page,
  ) {
    return PopupMenuItem(
      enabled: true,
      // 클릭시 페이지 이동
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return page;
            },
          ),
        );
      },
      child: Row(
        children: [
          const SizedBox(width: 6),
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
