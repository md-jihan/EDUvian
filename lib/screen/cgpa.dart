import 'package:eduvian/model/department.dart';
import 'package:eduvian/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          color: offWhite,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text("select Department (Optional)"),
                        const SizedBox(height: 4),
                        Consumer(
                          builder: (context, ref, child) {
                            return RoundedField(
                              child: DropdownButtonFormField(
                                value: ref.watch(departmentProvider),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                items: department.keys.map((dept) {
                                  return DropdownMenuItem(
                                    value: dept,
                                    child: Text(dept),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    ref
                                            .read(departmentProvider.notifier)
                                            .state =
                                        value,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Column(
                      children: [
                        const Text("select Semester (Optional)"),
                        const SizedBox(height: 4),
                        Consumer(
                          builder: (context, ref, child) {
                            return RoundedField(
                              child: DropdownButtonFormField(
                                value: ref.watch(semesterProvider),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                items: semester.map((dept) {
                                  return DropdownMenuItem(
                                    value: dept,
                                    child: Text(dept),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    ref.read(semesterProvider.notifier).state =
                                        value,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
