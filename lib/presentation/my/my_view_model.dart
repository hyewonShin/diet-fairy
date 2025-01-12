import 'package:diet_fairy/domain/entity/user.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/domain/entity/weight_goal.dart';
import 'package:diet_fairy/domain/entity/weight_record.dart';
import 'package:diet_fairy/data/dto/diet_evaluation_dto.dart';
import 'package:diet_fairy/data/data_source/firebase_diet_evaluation_data_source.dart';

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

class MyViewModel extends StateNotifier<MyState> {
  final Ref ref;
  final _evaluationDataSource = FirebaseDietEvaluationDataSource();

  MyViewModel(this.ref)
      : super(
          MyState(
            weightGoal: null,
            records: const [],
            user: ref.read(userGlobalViewModelProvider),
            isLoading: false,
          ),
        ) {
    // 사용자 정보 변경 감지
    ref.listen(userGlobalViewModelProvider, (previous, next) {
      if (next != null) {
        state = state.copyWith(
          user: next,
          isLoading: false,
        );
      }
    });
  }

  void refreshUserData() {
    final user = ref.read(userGlobalViewModelProvider);
    if (user != null) {
      state = state.copyWith(
        user: user,
        isLoading: false,
      );
    }
  }

  Future<void> addRecord(WeightRecord record) async {
    try {
      state = state.copyWith(
        records: [...state.records, record],
        isLoading: false,
      );
    } catch (e) {
      print('Error adding record: $e');
    }
  }

  Future<void> addEvaluation(String mood, String diet, String exercise) async {
    try {
      final user = ref.read(userGlobalViewModelProvider);
      if (user == null) return;

      final evaluation = DietEvaluationDto(
        id: DateTime.now().toIso8601String(), // 또는 UUID 사용
        userId: user.userId,
        date: DateTime.now(),
        mood: mood,
        diet: diet,
        exercise: exercise,
      );

      await _evaluationDataSource.addEvaluation(evaluation);

      // 로컬 상태 업데이트
      state = state.copyWith(
        records: [
          ...state.records,
          WeightRecord(
            date: evaluation.date,
            weight: user.weight,
            evaluation: {
              'mood': mood,
              'diet': diet,
              'exercise': exercise,
            },
          ),
        ],
      );
    } catch (e) {
      print('Error adding evaluation: $e');
    }
  }

  Future<void> loadMonthlyEvaluations() async {
    try {
      final user = ref.read(userGlobalViewModelProvider);
      if (user == null) return;

      final evaluations = await _evaluationDataSource.getMonthlyEvaluations(
          user.userId, DateTime.now());

      state = state.copyWith(
        records: evaluations
            .map((e) => WeightRecord(
                  date: e.date,
                  weight: user.weight,
                  evaluation: {
                    'mood': e.mood,
                    'diet': e.diet,
                    'exercise': e.exercise,
                  },
                ))
            .toList(),
      );
    } catch (e) {
      print('Error loading evaluations: $e');
    }
  }
}

final myViewModelProvider = StateNotifierProvider<MyViewModel, MyState>((ref) {
  return MyViewModel(ref);
});
