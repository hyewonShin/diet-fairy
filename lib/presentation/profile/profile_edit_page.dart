import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:flutter/material.dart';
import 'package:diet_fairy/domain/entity/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  late TextEditingController _weightController;
  late TextEditingController _desiredWeightController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.user.nickname);
    _weightController =
        TextEditingController(text: widget.user.weight.toString());
    _desiredWeightController =
        TextEditingController(text: widget.user.desiredWeight.toString());
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _weightController.dispose();
    _desiredWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = ref.watch(userGlobalViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: widget.user.imageUrl != null
                        ? NetworkImage(widget.user.imageUrl!)
                        : null,
                    child: widget.user.imageUrl == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 18),
                        color: Colors.white,
                        onPressed: () async {
                          // 이미지 선택 및 업로드 로직
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: '닉네임',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: '현재 체중',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _desiredWeightController,
              decoration: const InputDecoration(
                labelText: '목표 체중',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final updatedUser = User(
                    userId: widget.user.userId,
                    nickname: _nicknameController.text,
                    imageUrl: widget.user.imageUrl,
                    feedCreatedAt: widget.user.feedCreatedAt,
                    weight: int.parse(_weightController.text),
                    desiredWeight: int.parse(_desiredWeightController.text),
                    likeFeed: widget.user.likeFeed,
                  );

                  // UserGlobalViewModel을 통해 사용자 정보 업데이트
                  userViewModel.updateUser(updatedUser);
                  Navigator.pop(context);
                },
                child: const Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
