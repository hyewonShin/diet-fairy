class DietEvaluationDto {
  final String id;
  final String userId;
  final DateTime date;
  final String mood;
  final String diet;
  final String exercise;

  DietEvaluationDto({
    required this.id,
    required this.userId,
    required this.date,
    required this.mood,
    required this.diet,
    required this.exercise,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'mood': mood,
      'diet': diet,
      'exercise': exercise,
    };
  }

  factory DietEvaluationDto.fromJson(Map<String, dynamic> json) {
    return DietEvaluationDto(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      mood: json['mood'],
      diet: json['diet'],
      exercise: json['exercise'],
    );
  }
}
