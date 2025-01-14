import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diet_fairy/presentation/user_global_view_model.dart';
import 'package:diet_fairy/presentation/my/my_view_model.dart';

class WeightEditPage extends ConsumerStatefulWidget {
  const WeightEditPage({super.key});

  @override
  ConsumerState<WeightEditPage> createState() => _WeightEditPageState();
}

class _WeightEditPageState extends ConsumerState<WeightEditPage> {
  late TextEditingController _currentWeightController;
  late TextEditingController _desiredWeightController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userGlobalViewModelProvider);
    _currentWeightController =
        TextEditingController(text: user?.weight.toString());
    _desiredWeightController =
        TextEditingController(text: user?.desiredWeight.toString());
  }

  @override
  void dispose() {
    _currentWeightController.dispose();
    _desiredWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = ref.watch(userGlobalViewModelProvider.notifier);
    final user = ref.watch(userGlobalViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('목표 체중'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '체중 설정하기',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _currentWeightController,
              decoration: const InputDecoration(
                labelText: '현재 체중',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _desiredWeightController,
              decoration: const InputDecoration(
                labelText: '목표 체중',
                border: OutlineInputBorder(),
                suffixText: 'kg',
              ),
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    if (user != null) {
                      final currentWeight =
                          int.parse(_currentWeightController.text);
                      final desiredWeight =
                          int.parse(_desiredWeightController.text);

                      final updatedUser = user.copyWith(
                        weight: currentWeight,
                        desiredWeight: desiredWeight,
                      );

                      print(
                          'Updating weight - current: $currentWeight, desired: $desiredWeight');
                      await ref
                          .read(userGlobalViewModelProvider.notifier)
                          .updateWeight(updatedUser);

                      ref.read(myViewModelProvider.notifier).refreshUserData();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    '설정하기',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
