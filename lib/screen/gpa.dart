import 'package:eduvian/model/department.dart';
import 'package:eduvian/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              const SizedBox(height: 0),
              RoundedField(
                child: SubjectAutoComplete(
                  departmentProvider: departmentProvider,
                  departmentMap: department,
                  subjectProvider: subjectProvider,
                  fieldDecoration: fieldDecoration,
                ),
              ),
              const SizedBox(height: 16),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(
                              "${subject.Code} - ${subject.Credit}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: DropdownButtonFormField<String>(
                                value: ref.watch(gradeProvider)[subject.Code],
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

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
