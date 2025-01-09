import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/domain/usecase/get_weight_goal_use_case.dart';
import 'package:diet_fairy/domain/usecase/get_weight_records_use_case.dart';
import 'package:diet_fairy/domain/entity/weight_goal.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/data/repository/weight_repository_impl.dart';
import 'package:diet_fairy/data/data_source/mock_weight_data_source.dart';

class MyState {
  final WeightGoal? weightGoal;
  final List<WeightRecord> records;
  final bool isLoading;

  MyState({
    this.weightGoal,
    this.records = const [],
    this.isLoading = false,
  });

  MyState copyWith({
    WeightGoal? weightGoal,
    List<WeightRecord>? records,
    bool? isLoading,
  }) {
    return MyState(
      weightGoal: weightGoal ?? this.weightGoal,
      records: records ?? this.records,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final myViewModelProvider = StateNotifierProvider<MyViewModel, MyState>((ref) {
  final repository = WeightRepositoryImpl(MockWeightDataSource());

  return MyViewModel(
    getWeightGoalUseCase: GetWeightGoalUseCase(repository),
    getWeightRecordsUseCase: GetWeightRecordsUseCase(repository),
  );
});

class MyViewModel extends StateNotifier<MyState> {
  final GetWeightGoalUseCase getWeightGoalUseCase;
  final GetWeightRecordsUseCase getWeightRecordsUseCase;

  MyViewModel({
    required this.getWeightGoalUseCase,
    required this.getWeightRecordsUseCase,
  }) : super(MyState()) {
    _fetchData();
  }

  Future<void> _fetchData() async {
    state = state.copyWith(isLoading: true);

    try {
      final weightGoal = await getWeightGoalUseCase.execute();
      final records = await getWeightRecordsUseCase.execute(DateTime.now());

      state = state.copyWith(
        weightGoal: weightGoal,
        records: records,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // 에러 처리
    }
  }
}
