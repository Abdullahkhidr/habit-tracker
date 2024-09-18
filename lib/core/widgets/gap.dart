import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double value;
  const Gap({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value, height: value);
  }
}
