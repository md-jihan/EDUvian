import 'package:eduvian/model/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalCreditProvider = StateProvider<String>((ref) => '');
final totalGpaProvider = StateProvider<String>((ref) => '');
final cgpaListProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);

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
              Consumer(
                builder: (context, ref, child) {
                  final cgpaEnter = ref.watch(cgpaListProvider);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: cgpaEnter.length,
                      itemBuilder: (context, index) {
                        final data = cgpaEnter[index];
                        return Consumer(
                          builder: (context, ref, child) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(children: [Text("Jihan")]),
                            );
                          },
                        );
                      },
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
}
