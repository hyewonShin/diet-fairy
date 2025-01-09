import 'package:flutter/material.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/presentation/home/widgets/weight_header.dart';
import 'package:diet_fairy/presentation/home/widgets/weight_calendar.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      WeightRecord(date: DateTime(2024, 11, 1), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 2), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 12), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 13), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 19), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 26), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 27), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 28), weight: 6),
    ];

    return Column(
      children: [
        const WeightHeader(weight: 6),
        WeightCalendar(
          records: records,
          selectedMonth: DateTime(2024, 11),
        ),
      ],
    );
  }
}
