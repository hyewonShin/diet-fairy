import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  UserImage(this.userImage, this.size);
  String? userImage;
  double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: userImage == null || userImage!.isEmpty
          ? ClipOval(
              child: Image.asset(
                'assets/app/no-user-image.png',
                fit: BoxFit.fill,
              ),
            )
          : ClipOval(
              child: Image.network(
                userImage!,
                fit: BoxFit.fill,
              ),
            ),
    );
  }
}
