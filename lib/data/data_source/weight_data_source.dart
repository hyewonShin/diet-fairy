import 'package:diet_fairy/domain/model/weight_goal.dart';
import 'package:diet_fairy/domain/model/weight_record.dart';

abstract class WeightDataSource {
  Future<WeightGoal> getWeightGoal();
  Future<List<WeightRecord>> getWeightRecords(DateTime month);
}
