import 'package:diet_fairy/domain/entity/weight_goal.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';

abstract class WeightRepository {
  Future<WeightGoal> getWeightGoal();
  Future<List<WeightRecord>> getWeightRecords(DateTime month);
}
