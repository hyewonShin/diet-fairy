import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
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
  final weightRepository = WeightRepositoryImpl(MockWeightDataSource());

  return MyViewModel(
    getWeightGoalUseCase: GetWeightGoalUseCase(weightRepository),
    getWeightRecordsUseCase: GetWeightRecordsUseCase(weightRepository),
    ref: ref,
  );
});

class MyViewModel extends StateNotifier<MyState> {
  final GetWeightGoalUseCase getWeightGoalUseCase;
  final GetWeightRecordsUseCase getWeightRecordsUseCase;
  final Ref ref;

  MyViewModel({
    required this.getWeightGoalUseCase,
    required this.getWeightRecordsUseCase,
    required this.ref,
  }) : super(MyState()) {
    _fetchData();
  }

  Future<void> _fetchData() async {
    state = state.copyWith(isLoading: true);

    try {
      final weightGoalFuture = getWeightGoalUseCase.execute();
      final recordsFuture = getWeightRecordsUseCase.execute(DateTime.now());
      final user = ref.read(userGlobalViewModelProvider);

      final results = await Future.wait([
        weightGoalFuture,
        recordsFuture,
      ]);

      state = state.copyWith(
        weightGoal: results[0] as WeightGoal?,
        records: results[1] as List<WeightRecord>,
        user: user,
        isLoading: false,
      );

      print('Data fetched successfully: ${state.user?.nickname}');
    } catch (e, stackTrace) {
      print('Error fetching data: $e');
      print('Stack trace: $stackTrace');
      state = state.copyWith(isLoading: false);
    }
  }
}
