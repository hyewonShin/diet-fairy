import 'package:diet_fairy/domain/entity/weight_goal.dart';
import 'package:diet_fairy/domain/repository/weight_repository.dart';

class GetWeightGoalUseCase {
  final WeightRepository repository;

  GetWeightGoalUseCase(this.repository);

  Future<WeightGoal> execute() async {
    return await repository.getWeightGoal();
  }
}
