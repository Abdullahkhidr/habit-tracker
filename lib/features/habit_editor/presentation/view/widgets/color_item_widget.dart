import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';

class ColorItemWidget extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorItemWidget(
      {super.key, required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 10 : 0,
      margin: const EdgeInsets.all(0),
      shape: const CircleBorder(),
      child: CircleAvatar(
          backgroundColor: color, radius: kPaddingMedium.top * 1.7),
    );
  }
}
