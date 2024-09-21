import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';

class ColorItemWidget extends StatelessWidget {
  final Color color;
  const ColorItemWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: color, radius: kPaddingMedium.top * 1.7);
  }
}
