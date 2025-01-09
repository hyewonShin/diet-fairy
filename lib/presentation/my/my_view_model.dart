import 'package:diet_fairy/domain/entity/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/domain/usecase/get_weight_goal_use_case.dart';
import 'package:diet_fairy/domain/usecase/get_weight_records_use_case.dart';
import 'package:diet_fairy/domain/entity/weight_goal.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/data/repository/weight_repository_impl.dart';
import 'package:diet_fairy/data/repository/user_repository_provider.dart';
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
  final weightRepository = WeightRepositoryImpl(MockWeightDataSource());
  final userRepository = ref.watch(userRepositoryProvider);

  return MyViewModel(
    getWeightGoalUseCase: GetWeightGoalUseCase(weightRepository),
    getWeightRecordsUseCase: GetWeightRecordsUseCase(weightRepository),
    getUserUseCase: GetUserUseCase(userRepository),
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
      final weightGoalFuture = getWeightGoalUseCase.execute();
      final recordsFuture = getWeightRecordsUseCase.execute(DateTime.now());
      final userFuture = getUserUseCase.execute('current_user_id');

      final results = await Future.wait([
        weightGoalFuture,
        recordsFuture,
        userFuture,
      ]);

      state = state.copyWith(
        weightGoal: results[0] as WeightGoal?,
        records: results[1] as List<WeightRecord>,
        user: results[2] as User?,
        isLoading: false,
      );

      print('Data fetched successfully: ${state.user?.nickname}');
    } catch (e, stackTrace) {
      print('Error fetching data: $e');
      print('Stack trace: $stackTrace');

      state = state.copyWith(
        isLoading: false,
        user: User(
          userId: 'default_id',
          nickname: '사용자',
          imageUrl: null,
          feedCreatedAt: [],
          weight: 0,
          desiredWeight: 0,
          likeFeed: [],
        ),
      );
    }
  }
}
