import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'department.dart';

class RoundedField extends StatelessWidget {
  final Widget child;
  const RoundedField({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.3),
      ),
      child: child,
    );
  }
}

InputDecoration inputDecoration() => InputDecoration(
  filled: true,
  fillColor: Colors.white.withOpacity(0.2),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.white),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
);

class DropdownField extends ConsumerWidget {
  final StateProvider<String?> ProviderName;
  final List<String> item;
  final String? hintText;
  final void Function(WidgetRef ref, String?)? onChangeExtra;
  const DropdownField({
    Key? key,
    required this.ProviderName,
    required this.item,
    this.hintText,
    this.onChangeExtra,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectValue = ref.watch(ProviderName);
    return DropdownButtonFormField<String>(
      value: selectValue,
      decoration: inputDecoration(),
      dropdownColor: Colors.white,
      iconEnabledColor: Colors.white,
      style: const TextStyle(color: Colors.black),
      borderRadius: BorderRadius.circular(8),
      items: [
        if (hintText != null)
          DropdownMenuItem<String>(value: null, child: Text(hintText!)),

        ...item.map((value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ],
      onChanged: (newValue) {
        ref.read(ProviderName.notifier).state = newValue!;
        if (onChangeExtra != null) {
          onChangeExtra!(ref, newValue);
        }
      },
    );
  }
}

InputDecoration fieldDecoration({String? hint, IconData? icon}) =>
    InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

class SubjectAutoComplete extends ConsumerWidget {
  final StateProvider<String?> departmentProvider;
  final Map<String?, List<Subject>> departmentMap;
  final StateProvider<List<Subject>> subjectProvider;
  final InputDecoration Function({required String hint, required IconData icon})
  fieldDecoration;
  const SubjectAutoComplete({
    super.key,
    required this.departmentProvider,
    required this.departmentMap,
    required this.subjectProvider,
    required this.fieldDecoration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Autocomplete<Subject>(
      optionsBuilder: (TextEditingValue subjectName) {
        final departmentf = ref.watch(departmentProvider);
        final departmentList = departmentMap[departmentf] ?? [];
        if (departmentf == '') {
          return const Iterable<Subject>.empty();
        }
        if (subjectName.text.trim().isEmpty) {
          return departmentList;
        }
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
          (Subject option) => '${option.Code} ${option.Title}',

      fieldViewBuilder: (context, controller, focuseNode, onEditingComplete) {
        return TextField(
          controller: controller,
          focusNode: focuseNode,
          onTap: () {
            controller.clear(); // clear directly
            controller.selection = TextSelection.collapsed(
              offset: controller.text.length,
            );
          },
          onEditingComplete: onEditingComplete,
          decoration: fieldDecoration(
            hint: 'Search Subject',
            icon: Icons.search,
          ),
        );
      },
      onSelected: (Subject subjects) {
        final current = ref.read(subjectProvider);

        if (!current.contains(subjects)) {
          ref.read(subjectProvider.notifier).state = [...current, subjects];
        }
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: ((options.length * 50.0).clamp(0, 5 * 50.0)),
                maxWidth: (MediaQuery.of(context).size.width) * 0.915,
              ),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 4),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      option.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () => onSelected(option),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusColor: Colors.teal.shade100.withOpacity(0.3),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
