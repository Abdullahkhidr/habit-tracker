import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double value;
  Gap(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value, height: value);
  }
}
