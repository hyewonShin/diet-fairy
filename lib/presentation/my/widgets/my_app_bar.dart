import 'package:diet_fairy/presentation/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:diet_fairy/domain/entity/user.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final VoidCallback onProfileTap;
  final VoidCallback onHomeTap;

  const MyAppBar({
    super.key,
    required this.user,
    required this.onProfileTap,
    required this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.home),
        onPressed: onHomeTap,
      ),
      actions: [
        GestureDetector(
          onTap: onProfileTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: CircleAvatar(
              backgroundImage: user.imageUrl == null || user.imageUrl!.isEmpty
                  ? null
                  : NetworkImage(user.imageUrl!),
              child: UserImage(user.imageUrl, 50),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
