import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:flutter/material.dart';
import 'package:diet_fairy/domain/entity/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  final User user;

  const ProfileEditPage({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  late TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.user.nickname);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image != null) {
        print('Selected image path: ${image.path}');
        await ref
            .read(userGlobalViewModelProvider.notifier)
            .updateProfileImage(widget.user.userId, image.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userGlobalViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 프로필 이미지
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user?.imageUrl?.isNotEmpty == true
                        ? NetworkImage(user!.imageUrl!)
                        : null,
                    child: user?.imageUrl?.isNotEmpty != true
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 닉네임 입력 필드
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: '닉네임',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            // 저장 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      print('Save button pressed');
                      final user = ref.read(userGlobalViewModelProvider);
                      if (user != null) {
                        print('Current user: ${user.nickname}');
                        // 닉네임이 변경된 새로운 User 객체 생성
                        final updatedUser = user.copyWith(
                          nickname: _nicknameController.text,
                        );
                        print('Updated user: ${updatedUser.nickname}');

                        // UserGlobalViewModel을 통해 업데이트
                        await ref
                            .read(userGlobalViewModelProvider.notifier)
                            .updateUser(updatedUser);

                        print('Update completed');
                      }
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      print('Error saving profile changes: $e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('저장'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
