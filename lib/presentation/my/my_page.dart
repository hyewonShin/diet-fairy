import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/presentation/my/my_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/presentation/my/widgets/my_app_bar.dart';
import 'package:diet_fairy/presentation/home/home_page.dart';
import 'package:diet_fairy/presentation/profile/profile_edit_page.dart';
import 'package:diet_fairy/presentation/my/widgets/weight_header.dart';
import 'package:diet_fairy/presentation/evaluation/diet_evaluation_page.dart';

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
            WeightHeader(
              currentWeight: state.user!.weight,
              desiredWeight: state.user!.desiredWeight,
            ),
            // 캘린더 영역
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '이번달 도전 일기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      '${DateTime.now().month}월',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCalendar(state.records),
                  const SizedBox(height: 24), // 캘린더와 버튼 사이 여백
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DietEvaluationPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        '오늘의 다이어트 평가하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: daysInMonth,
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
            color: hasRecord ? Colors.blue.withOpacity(0.1) : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '$day',
                style: TextStyle(
                  color: hasRecord ? Colors.blue[900] : Colors.grey[600],
                  fontWeight: hasRecord ? FontWeight.bold : null,
                ),
              ),
              if (hasRecord)
                Image.asset(
                  'assets/fairy_stamp.png',
                  width: 24,
                  height: 24,
                  opacity: const AlwaysStoppedAnimation(0.7),
                ),
            ],
          ),
        );
      },
    );
  }
}
