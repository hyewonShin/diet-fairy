import 'package:flutter/material.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';

class WeightCalendar extends StatelessWidget {
  final List<WeightRecord> records;
  final DateTime selectedMonth;

  const WeightCalendar({
    super.key,
    required this.records,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCalendarHeader(),
        _buildCalendarBody(),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            '이번달 도전 일기',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const Spacer(),
          Text(
            '2024년 11월',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarBody() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 31, // 임시로 31일로 설정
      itemBuilder: (context, index) {
        final date = index + 1;
        final hasRecord = records.any((record) =>
            record.date.day == date &&
            record.date.month == selectedMonth.month);

        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hasRecord ? Colors.blue.withOpacity(0.2) : null,
          ),
          child: Center(
            child: Text(
              '$date',
              style: TextStyle(
                color: hasRecord ? Colors.blue : Colors.grey[600],
                fontWeight: hasRecord ? FontWeight.bold : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
