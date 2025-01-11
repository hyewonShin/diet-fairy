import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/presentation/my/my_view_model.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DietEvaluationPage extends ConsumerStatefulWidget {
  const DietEvaluationPage({super.key});

  @override
  ConsumerState<DietEvaluationPage> createState() => _DietEvaluationPageState();
}

class _DietEvaluationPageState extends ConsumerState<DietEvaluationPage> {
  String? selectedMood;
  String? selectedDiet;
  String? selectedExercise;

  final moodIcons = {
    '기분 최고': Icons.sentiment_very_satisfied,
    '행복해': Icons.sentiment_satisfied,
    '신나': Icons.mood,
    '평온해': Icons.sentiment_neutral,
    '그냥 그래': Icons.sentiment_dissatisfied,
    '슬퍼': Icons.sentiment_very_dissatisfied,
  };

  final dietIcons = {
    '살빠짐': Icons.thumb_up,
    '유지어터': Icons.restaurant,
    '살쪘어': Icons.mood_bad,
    '목표 달성': Icons.flag,
    '단식 성공': Icons.no_food,
  };

  final exerciseIcons = {
    '오운완': Icons.check_circle,
    '쉬는날': Icons.hotel,
    '유산소': Icons.directions_run,
    '근력운동': Icons.fitness_center,
    '가볍게 걷기': Icons.directions_walk,
  };

  Widget _buildCategorySection(String title, Map<String, IconData> items,
      String? selectedValue, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 6,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: items.entries.map((entry) {
            final isSelected = selectedValue == entry.key;
            return GestureDetector(
              onTap: () => onSelect(entry.key),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      entry.value,
                      color: isSelected ? Colors.white : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? Colors.blue : Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 다이어트 평가'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '각 항목별로\n오늘의 다이어트를 표현해 보세요',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              _buildCategorySection('기분', moodIcons, selectedMood, (value) {
                setState(() => selectedMood = value);
              }),
              const SizedBox(height: 32),
              _buildCategorySection('다이어트', dietIcons, selectedDiet, (value) {
                setState(() => selectedDiet = value);
              }),
              const SizedBox(height: 32),
              _buildCategorySection('운동', exerciseIcons, selectedExercise,
                  (value) {
                setState(() => selectedExercise = value);
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: selectedMood != null &&
                    selectedDiet != null &&
                    selectedExercise != null
                ? () async {
                    final user = ref.read(userGlobalViewModelProvider);
                    if (user != null) {
                      // 현재 날짜의 기록 생성
                      final record = WeightRecord(
                        date: DateTime.now(),
                        weight: user.weight,
                        evaluation: {
                          'mood': selectedMood!,
                          'diet': selectedDiet!,
                          'exercise': selectedExercise!,
                        },
                      );

                      // MyViewModel에 기록 추가
                      await ref
                          .read(myViewModelProvider.notifier)
                          .addRecord(record);

                      if (mounted) {
                        Navigator.pop(context);
                      }
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              '완료',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
