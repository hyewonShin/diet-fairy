class DietEvaluation {
  final String id;
  final String userId;
  final DateTime date;
  final String mood; // 기분
  final String diet; // 다이어트
  final String exercise; // 운동

  DietEvaluation({
    required this.id,
    required this.userId,
    required this.date,
    required this.mood,
    required this.diet,
    required this.exercise,
  });
}
