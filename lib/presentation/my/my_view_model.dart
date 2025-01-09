import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/domain/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/domain/usecase/get_weight_goal_use_case.dart';
import 'package:diet_fairy/domain/usecase/get_weight_records_use_case.dart';
import 'package:diet_fairy/domain/entity/weight_goal.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/data/repository/weight_repository_impl.dart';
import 'package:diet_fairy/data/data_source/mock_weight_data_source.dart';
import 'package:diet_fairy/domain/usecase/get_user_use_case.dart';

class MyState {
  final WeightGoal? weightGoal;
  final List<WeightRecord> records;
  final User? user;
  final bool isLoading;

  MyState({
    this.weightGoal,
    this.records = const [],
    this.user,
    this.isLoading = false,
  });

  MyState copyWith({
    WeightGoal? weightGoal,
    List<WeightRecord>? records,
    User? user,
    bool? isLoading,
  }) {
    return MyState(
      weightGoal: weightGoal ?? this.weightGoal,
      records: records ?? this.records,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final myViewModelProvider = StateNotifierProvider<MyViewModel, MyState>((ref) {
  final repository = WeightRepositoryImpl(MockWeightDataSource());

  return MyViewModel(
    getWeightGoalUseCase: GetWeightGoalUseCase(repository),
    getWeightRecordsUseCase: GetWeightRecordsUseCase(repository),
    getUserUseCase: GetUserUseCase(repository as UserRepository),
  );
});

class MyViewModel extends StateNotifier<MyState> {
  final GetWeightGoalUseCase getWeightGoalUseCase;
  final GetWeightRecordsUseCase getWeightRecordsUseCase;
  final GetUserUseCase getUserUseCase;

  MyViewModel({
    required this.getWeightGoalUseCase,
    required this.getWeightRecordsUseCase,
    required this.getUserUseCase,
  }) : super(MyState()) {
    _fetchData();
  }

  Future<void> _fetchData() async {
    state = state.copyWith(isLoading: true);

    try {
      final weightGoal = await getWeightGoalUseCase.execute();
      final records = await getWeightRecordsUseCase.execute(DateTime.now());
      final user = await getUserUseCase.execute('current_user_id');

      state = state.copyWith(
        weightGoal: weightGoal,
        records: records,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}
