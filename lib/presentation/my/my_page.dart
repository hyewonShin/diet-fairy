import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/presentation/comment/comment_bottom_sheet.dart';
import 'package:diet_fairy/presentation/my/my_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/presentation/my/widgets/my_app_bar.dart';
import 'package:diet_fairy/presentation/home/home_page.dart';
import 'package:diet_fairy/presentation/profile/profile_edit_page.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myViewModelProvider);

    if (state.isLoading || state.user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: MyAppBar(
        user: state.user!,
        onProfileTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileEditPage(user: state.user!),
            ),
          );
        },
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(state.user!),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 체중 표시 영역
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '목표 체중까지',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue[900],
                    ),
                  ),
                  Text(
                    '${state.weightGoal?.remainingWeight}kg 남았어요',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ],
              ),
            ),
            // 캘린더 영역
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '이번달 도전 일기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // 댓글 보기 버튼 추가
                      TextButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const CommentBottomSheet(),
                          );
                        },
                        icon: const Icon(Icons.comment),
                        label: const Text('댓글 보기'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildCalendar(state.records),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(List<WeightRecord> records) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day; // 현재 달의 총 일수

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: daysInMonth, // 31 대신 실제 달의 일수 사용
      itemBuilder: (context, index) {
        final day = index + 1;
        final hasRecord = records.any((record) =>
            record.date.year == now.year &&
            record.date.month == now.month &&
            record.date.day == day);

        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hasRecord ? Colors.blue.withOpacity(0.2) : null,
          ),
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                color: hasRecord ? Colors.blue[900] : Colors.grey[600],
                fontWeight: hasRecord ? FontWeight.bold : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
