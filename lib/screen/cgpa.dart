import 'package:eduvian/model/department.dart';
import 'package:eduvian/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalCreditProvider = StateProvider<String>((ref) => '');
final totalGpaProvider = StateProvider<String>((ref) => '');
final SemesterListProvider = StateProvider<List<Map<String, dynamic>>>(
  (ref) => [],
);
final cgpaProvider = Provider<double>((ref) {
  final semesters = ref.watch(SemesterListProvider);
  double totalCredit = 0;
  double totalWetghtedGPA = 0;

  for (var semester in semesters) {
    final credit = semester['credit'] as double;
    final gpa = semester['gpa'] as double;

    totalCredit += credit;
    totalWetghtedGPA += gpa * credit;
  }
  if (totalCredit == 0) return 0;
  return totalWetghtedGPA / totalCredit;
});

class CgpaCalculation extends ConsumerStatefulWidget {
  const CgpaCalculation({super.key});

  @override
  ConsumerState<CgpaCalculation> createState() => _CgpaCalculationState();
}

class _CgpaCalculationState extends ConsumerState<CgpaCalculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "CGPA"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          color: offWhite,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return DropdownButtonFormField<String>(
                    value: ref.watch(departmentProvider),
                    decoration: const InputDecoration(labelText: "Department"),
                    items:
                        department.keys
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (value) {
                      ref.read(departmentProvider.notifier).state = value;
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  return DropdownButtonFormField(
                    value: ref.watch(semesterProvider),
                    decoration: const InputDecoration(labelText: "semester"),
                    items:
                        semester
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (value) {
                      ref.read(semesterProvider.notifier).state = value;
                    },
                  );
                },
              ),
              const SizedBox(height: 10),

              Consumer(
                builder: (context, ref, child) {
                  return TextField(
                    decoration: const InputDecoration(
                      labelText: 'Total Credit',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged:
                        (value) =>
                            ref.read(totalCreditProvider.notifier).state =
                                value,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
