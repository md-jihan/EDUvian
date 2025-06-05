import 'package:eduvian/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/department.dart';

final scholoarshipProvider = StateProvider<String>((ref) => 'Default');
final Map<String, int> items = {'BoT': 1750, 'VMSP': 1400, 'Default': 2200};

final discountProvider = StateProvider<bool>((ref) => false);

class CreditCalculation extends ConsumerStatefulWidget {
  const CreditCalculation({super.key});

  @override
  ConsumerState<CreditCalculation> createState() => _CreditCalculationState();
}

class _CreditCalculationState extends ConsumerState<CreditCalculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar(context, "EDUvian"),

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: offWhite,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select Scholarship',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Consumer(
                                  builder: (context, ref, child) {
                                    return RoundedField(
                                      child: DropdownField(
                                        ProviderName: scholoarshipProvider,
                                        item: items.keys.toList(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select Department',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                  ),
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
                                          ref
                                              .watch(subjectProvider.notifier)
                                              .state = [];
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      if (ref.watch(departmentProvider) != null)
                        const Text(
                          'Search Subject',
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),

                      const SizedBox(height: 5),
                      if (ref.watch(departmentProvider) != null)
                        Consumer(
                          builder: (context, ref, child) {
                            return RoundedField(
                              child: SubjectAutoComplete(
                                departmentProvider: departmentProvider,
                                departmentMap: department,
                                subjectProvider: subjectProvider,
                                fieldDecoration: fieldDecoration,
                              ),
                            );
                          },
                        ),

                      Consumer(
                        builder: (context, ref, child) {
                          final selected = ref.watch(subjectProvider);

                          return Expanded(
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                itemCount: selected.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final subject = selected[index];
                                  return _subjectTile(subject, ref);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Consumer(
                builder: (context, ref, child) {
                  final selected = ref.watch(subjectProvider);
                  final totalCredit = selected.fold<double>(
                    0,
                    (prev, subject) => prev + subject.Credit,
                  );
                  final rate = items[ref.watch(scholoarshipProvider)] ?? 0;
                  double totalCost = rate * totalCredit;
                  if (ref.watch(discountProvider)) {
                    totalCost *= 0.95;
                  }
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      //border: Border.all(color: Colors.white, width: 2),
                      border: BorderDirectional(
                        top: BorderSide(width: 2, color: Colors.white),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        _infoRow(
                          'Total Credits: ',
                          totalCredit.toStringAsFixed(1),
                        ),
                        _infoRow('Apply Per Credit', rate.toStringAsFixed(0)),
                        GestureDetector(
                          onTap: () {
                            ref.read(discountProvider.notifier).state =
                                !ref.read(discountProvider);
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: ref.watch(discountProvider),
                                onChanged: (value) {
                                  ref.read(discountProvider.notifier).state =
                                      value ?? false;
                                },
                                activeColor: Colors.tealAccent,
                              ),
                              const Text(
                                'Apply 5% Discount',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        _infoRow('Total Cost: ', totalCost.toStringAsFixed(2)),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subjectTile(Subject subject, WidgetRef ref) => Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white.withOpacity(0.5),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '${subject.Code} - ${subject.Title}',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Text('${subject.Credit}', style: const TextStyle(color: Colors.black)),
        IconButton(
          onPressed: () {
            final update =
                ref.read(subjectProvider.notifier).state..remove(subject);
            ref.read(subjectProvider.notifier).state = [...update];
          },
          icon: const Icon(Icons.delete, color: Colors.redAccent),
        ),
      ],
    ),
  );

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(value, style: const TextStyle(color: Colors.black)),
      ],
    ),
  );
}
