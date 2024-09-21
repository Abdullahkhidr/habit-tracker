import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';

class OptionWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onSelect;
  final BorderRadius? borderRadius;
  final Color? unSelectedBackgroundColor;
  final EdgeInsets? padding;
  const OptionWidget(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onSelect,
      this.borderRadius,
      this.unSelectedBackgroundColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: padding,
            backgroundColor: isSelected
                ? kPrimaryColor
                : unSelectedBackgroundColor ?? kHintColor.withOpacity(0.5),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: isSelected ? Colors.transparent : kHintColor),
                borderRadius: borderRadius ?? kBorderRadiusSmall)),
        onPressed: onSelect,
        child: Text(title,
            style: TextStyles.b4
                .copyWith(color: isSelected ? kOnPrimaryColor : kTextColor)));
  }
}
