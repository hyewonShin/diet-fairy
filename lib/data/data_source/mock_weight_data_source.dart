import 'package:diet_fairy/data/data_source/weight_data_source.dart';
import 'package:diet_fairy/domain/entity/weight_goal.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';

// 임시 데이터 소스
// 실제 데이터 소스는 WeightDataSource 클래스에 있음

class MockWeightDataSource implements WeightDataSource {
  @override
  Future<WeightGoal> getWeightGoal() async {
    return WeightGoal(
      remainingWeight: 6.0,
      date: DateTime.now(),
    );
  }

  @override
  Future<List<WeightRecord>> getWeightRecords(DateTime month) async {
    return [
      WeightRecord(date: DateTime(2024, 11, 1), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 2), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 12), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 13), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 19), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 26), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 27), weight: 6),
      WeightRecord(date: DateTime(2024, 11, 28), weight: 6),
    ];
  }
}
