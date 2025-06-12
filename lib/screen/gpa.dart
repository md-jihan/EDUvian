import 'package:eduvian/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gradeToPoint = <String, double>{
  'A': 4.0,
  'A-': 3.7,
  'B+': 3.3,
  'B': 3.0,
  'B-': 2.7,
  'C+': 2.3,
  'C': 2.0,
  'C-': 1.7,
  'D+': 1.3,
  'D': 1.0,
  'F': 0.0,
};
final gradesProvider = StateProvider<List<String>>((ref) => []);
final gpaProvider = Provider<double>((ref) {
  final grades = ref.watch(gradesProvider);
  if (grades.isEmpty) return 0.0;

  final validGrades = grades.where(gradeToPoint.containsKey);
  final totalPoints = validGrades
      .map((g) => gradeToPoint[g]!)
      .reduce((a, b) => a + b);
  return totalPoints / validGrades.length;
});

class GpaCalculation extends ConsumerStatefulWidget {
  const GpaCalculation({super.key});

  @override
  ConsumerState<GpaCalculation> createState() => _GpaCalculationState();
}

class _GpaCalculationState extends ConsumerState<GpaCalculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "GPA"),
      body: Consumer(
        builder: (context, ref, _) {
          final gpa = ref.watch(gpaProvider);
          final grades = ref.watch(gradesProvider);

          return Column(
            children: [
              Text("Your GPA: ${gpa.toStringAsFixed(2)}"),
              Wrap(
                spacing: 8,
                children: grades.map((g) => Chip(label: Text(g))).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(gradesProvider.notifier).state = [];
                },
                child: Text("Reset"),
              ),
            ],
          );
        },
      ),
    );
  }
}
