import 'package:flutter/material.dart';

class DurationFilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final Function() onTap;
  final TextStyle? textStyle;

  const DurationFilterButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: textStyle ?? const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
