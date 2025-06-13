import 'package:eduvian/model/department.dart';
import 'package:eduvian/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gradeProvider = StateProvider<Map<String, String>>((ref) => {});
const gradeToPoint = {'A': 4.0, 'A-': 3.7};
final gpaProvider = Provider<double>((ref) {
  final subjects = ref.watch(subjectProvider);
  final grades = ref.watch(gradeProvider);

  double totalPoints = 0;
  double totalCredits = 0;
  for (var subject in subjects) {
    final grade = grades[subject.Code];
    final credit = subject.Credit;
    if (grade != null && gradeToPoint.containsKey(grade)) {
      final point = gradeToPoint[grade]!;
      totalPoints += point * credit;
      totalCredits += credit;
    }
  }
  return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
});

class GpaCalculation extends ConsumerStatefulWidget {
  const GpaCalculation({super.key});

  @override
  ConsumerState<GpaCalculation> createState() => _GpaCalculationState();
}

class _GpaCalculationState extends ConsumerState<GpaCalculation> {
  @override
  Widget build(BuildContext context) {
    final subjects = ref.watch(subjectProvider);
    final gpa = ref.watch(gpaProvider);

    return Scaffold(
      appBar: appBar(context, "GPA"),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: offWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
        ),
      ),
    );
  }
}
