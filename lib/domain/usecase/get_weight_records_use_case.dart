import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/domain/repository/weight_repository.dart';

class GetWeightRecordsUseCase {
  final WeightRepository repository;

  GetWeightRecordsUseCase(this.repository);

  Future<List<WeightRecord>> execute(DateTime month) async {
    return await repository.getWeightRecords(month);
  }
}
