import 'package:diet_fairy/data/data_source/weight_data_source.dart';
import 'package:diet_fairy/domain/entity/weight_goal.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/domain/repository/weight_repository.dart';

class WeightRepositoryImpl implements WeightRepository {
  final WeightDataSource dataSource;

  WeightRepositoryImpl(this.dataSource);

  @override
  Future<WeightGoal> getWeightGoal() async {
    return await dataSource.getWeightGoal();
  }

  @override
  Future<List<WeightRecord>> getWeightRecords(DateTime month) async {
    return await dataSource.getWeightRecords(month);
  }
}
