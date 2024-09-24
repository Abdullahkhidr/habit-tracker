import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';

class SwitchWidget extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;
  const SwitchWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
        contentPadding: const EdgeInsets.all(0),
        title: Text(title, style: TextStyles.h3),
        value: value,
        onChanged: onChanged);
  }
}
