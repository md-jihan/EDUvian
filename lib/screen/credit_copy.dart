import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../model/department.dart';

final scholoarshipProvider = StateProvider<String>((ref) => 'Default');
final departmentProvider = StateProvider<String?>((ref) => null);
final Map<String, int> items = {'BoT': 1750, 'VMSP': 1400, 'Default': 2200};
final subjectProvider = StateProvider<List<Subject>>((ref) => []);

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
      backgroundColor: const Color(0xFF0F2027),
      appBar: AppBar(
        //extendBodyBehindAppBar: true,
        title: Text(
          'EDUvian',
          style: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 2,
                color: const Color.fromARGB(97, 0, 0, 0),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(203, 4, 4, 1),
        foregroundColor: Colors.white,

        leading: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back,
            shadows: [
              Shadow(
                blurRadius: 2,
                color: const Color.fromARGB(97, 0, 0, 0),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff309898),
                Color.fromARGB(255, 74, 193, 193),
                Color.fromARGB(255, 231, 173, 146),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(104, 255, 255, 255),
              border: Border.all(color: Colors.white, width: 2),
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
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      return _roundedField(
                                        child: DropdownButtonFormField<String>(
                                          value: ref.watch(
                                            scholoarshipProvider,
                                          ),
                                          decoration: _inputDecoration(),
                                          dropdownColor: Colors.black87,
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          items:
                                              items.keys.map((value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                          onChanged: (newValue) {
                                            ref
                                                .read(
                                                  scholoarshipProvider.notifier,
                                                )
                                                .state = newValue!;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Select Department',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      return _roundedField(
                                        child: DropdownButtonFormField<String>(
                                          value: ref.watch(departmentProvider),
                                          decoration: _inputDecoration(),
                                          dropdownColor: Colors.black87,
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: null,
                                              child: Text(
                                                'Select a department',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            ...department.keys.map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ],
                                          onChanged: (newValue) {
                                            ref
                                                .read(
                                                  departmentProvider.notifier,
                                                )
                                                .state = newValue;
                                            ref
                                                .read(subjectProvider.notifier)
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),

                        const SizedBox(height: 10),
                        if (ref.watch(departmentProvider) != null)
                          Consumer(
                            builder: (context, ref, child) {
                              return _roundedField(
                                child: Autocomplete<Subject>(
                                  optionsBuilder: (
                                    TextEditingValue subjectName,
                                  ) {
                                    final departmentf = ref.watch(
                                      departmentProvider,
                                    );
                                    final departmentList =
                                        department[departmentf] ?? [];
                                    if (departmentf == '')
                                      return const Iterable<Subject>.empty();
                                    return departmentList.where(
                                      (subject) =>
                                          subject.Code.toLowerCase().contains(
                                            subjectName.text.toLowerCase(),
                                          ) ||
                                          subject.Title.toLowerCase().contains(
                                            subjectName.text.toLowerCase(),
                                          ),
                                    );
                                  },
                                  displayStringForOption:
                                      (Subject option) =>
                                          '${option.Code} ${option.Title}',
                                  onSelected: (Subject subjects) {
                                    final current = ref.read(subjectProvider);

                                    if (!current.contains(subjects)) {
                                      ref
                                          .read(subjectProvider.notifier)
                                          .state = [...current, subjects];
                                    }
                                  },
                                  fieldViewBuilder: (
                                    context,
                                    controller,
                                    focusNode,
                                    onEditingComplete,
                                  ) {
                                    return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      onEditingComplete: onEditingComplete,
                                      decoration: _fieldDecoration(
                                        hint: 'Search Subject',
                                        icon: Icons.search,
                                      ),
                                    );
                                  },
                                  optionsViewBuilder: (
                                    context,
                                    onSelected,
                                    options,
                                  ) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        elevation: 4.0,
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight: 5 * 50.0,
                                            maxWidth:
                                                (MediaQuery.of(
                                                  context,
                                                ).size.width) *
                                                0.915,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            itemCount: options.length,
                                            itemBuilder: (context, index) {
                                              final option = options.elementAt(
                                                index,
                                              );
                                              return ListTile(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                title: Text(
                                                  option.toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                onTap: () => onSelected(option),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                hoverColor: Colors.teal.shade100
                                                    .withOpacity(0.3),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),

                        Consumer(
                          builder: (context, ref, child) {
                            final selected = ref.watch(subjectProvider);

                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  ...selected
                                      .map(
                                        (subject) => _subjectTile(subject, ref),
                                      )
                                      .toList(),
                                ],
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
                          _infoRow('Apply so Credit', rate.toStringAsFixed(0)),
                          Row(
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
                          _infoRow(
                            'Total Cost: ',
                            totalCost.toStringAsFixed(2),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({String? hint, IconData? icon}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      );
  Widget _roundedField({required Widget child}) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white.withOpacity(0.3),
    ),
    child: child,
  );

  Widget _subjectTile(Subject subject, WidgetRef ref) => Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
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

  InputDecoration _inputDecoration() => InputDecoration(
    filled: true,
    fillColor: Colors.white.withOpacity(0.2),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  Widget _glassCard({required Widget child, EdgeInsets? padding}) => Container(
    padding: padding ?? const EdgeInsets.all(12),
    decoration: BoxDecoration(
      //color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      //border: Border.all(color: Colors.white.withOpacity(0.5)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: child,
  );
  Widget _summaryRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}
