class WeightRecord {
  final DateTime date;
  final int weight;
  final Map<String, String>? evaluation;

  WeightRecord({
    required this.date,
    required this.weight,
    this.evaluation,
  });
}
