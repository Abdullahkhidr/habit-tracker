import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';

class ColorItemWidget extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorItemWidget(
      {super.key, required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpaceExtraLarge * 2.3,
      width: kSpaceExtraLarge * 2.3,
      decoration: BoxDecoration(
          color: color,
          borderRadius: kBorderRadiusSmall,
          border: Border.all(
              width: 4,
              color: isSelected ? kSuccessColor : Colors.transparent)),
    );
  }
}
