import 'package:flutter/material.dart';

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
