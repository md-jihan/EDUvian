import 'package:eduvian/model/department.dart';
import 'package:eduvian/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final departmentProvider = StateProvider<String?>((ref) => null);
final subjectProvider = StateProvider<List<Subject>>((ref) => []);
final gradeProvider = StateProvider<Map<String, String>>((ref) => {});

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

const gradeToPoint = {
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
          child: Column(
            children: [
              /// Department dropdown
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Department',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Consumer(
                      builder: (context, ref, child) {
                        return RoundedField(
                          child: DropdownField(
                            ProviderName: departmentProvider,
                            item: department.keys.toList(),
                            hintText: "Select a department",
                            onChangeExtra: (ref, newValue) {
                              ref.watch(subjectProvider.notifier).state = [];
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              /// Subject Autocomplete
              SubjectAutoComplete(
                departmentProvider: departmentProvider,
                departmentMap: department,
                subjectProvider: subjectProvider,
                fieldDecoration: ({
                  required String hint,
                  required IconData icon,
                }) {
                  return InputDecoration(
                    hintText: hint,
                    prefixIcon: Icon(icon),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              /// Grade + Credit input for each subject
              Expanded(
                flex: 4,
                child: ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${subject.Code} - ${subject.Title}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value:
                                        ref.watch(gradeProvider)[subject.Code],
                                    decoration: const InputDecoration(
                                      labelText: "Grade",
                                      border: OutlineInputBorder(),
                                    ),
                                    items:
                                        gradeToPoint.keys
                                            .map(
                                              (grade) => DropdownMenuItem(
                                                value: grade,
                                                child: Text(grade),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (value) {
                                      final current = ref.read(gradeProvider);
                                      ref.read(gradeProvider.notifier).state = {
                                        ...current,
                                        subject.Code: value ?? '',
                                      };
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: subject.Credit.toString(),
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      labelText: "Credit",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// GPA Result
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "Total GPA: ${gpa.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
