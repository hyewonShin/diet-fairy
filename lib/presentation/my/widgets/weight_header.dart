import 'package:diet_fairy/presentation/my/weight_edit_page.dart';
import 'package:flutter/material.dart';

class WeightHeader extends StatelessWidget {
  final int currentWeight;
  final int desiredWeight;

  const WeightHeader({
    super.key,
    required this.currentWeight,
    required this.desiredWeight,
  });

  @override
  Widget build(BuildContext context) {
    final difference = currentWeight - desiredWeight;
    final status = difference > 0 ? '감량' : '증량';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WeightEditPage(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '목표 체중까지',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${difference.abs()}kg $status',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
