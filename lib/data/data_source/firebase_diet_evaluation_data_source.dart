import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_fairy/data/dto/diet_evaluation_dto.dart';

class FirebaseDietEvaluationDataSource {
  final firestore = FirebaseFirestore.instance;

  Future<void> addEvaluation(DietEvaluationDto evaluation) async {
    await firestore
        .collection('evaluations')
        .doc(evaluation.id)
        .set(evaluation.toJson());
  }

  Future<List<DietEvaluationDto>> getMonthlyEvaluations(
      String userId, DateTime month) async {
    final startDate = DateTime(month.year, month.month, 1);
    final endDate = DateTime(month.year, month.month + 1, 0);

    final snapshot = await firestore
        .collection('evaluations')
        .where('userId', isEqualTo: userId)
        .orderBy('date')
        .get();

    return snapshot.docs
        .map((doc) => DietEvaluationDto.fromJson(doc.data()))
        .where((evaluation) {
      return evaluation.date
              .isAfter(startDate.subtract(const Duration(days: 1))) &&
          evaluation.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }
}
