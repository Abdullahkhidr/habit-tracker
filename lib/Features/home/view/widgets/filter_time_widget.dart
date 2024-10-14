import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'duration_filter_button.dart';

class FilterTimeWidget extends StatelessWidget {
  final int selectedMainFilterIndex;
  final Function(int) onSelect;
  const FilterTimeWidget({
    super.key,
    required this.selectedMainFilterIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> timeFilters = ['Today', 'Weekly'];
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: kPaddingMedium.copyWith(bottom: 0, top: 5),
      decoration:
          BoxDecoration(color: kHintColor, borderRadius: kBorderRadiusMedium),
      child: Row(
        children: List.generate(timeFilters.length, (index) {
          bool isSelected = selectedMainFilterIndex == index;
          return Expanded(
            child: Container(
              padding: kPaddingExtraSmall,
              decoration:
                  BoxDecoration(color: isSelected ? kPrimaryColor : kHintColor),
              child: DurationFilterButton(
                label: timeFilters[index],
                selected: isSelected,
                onTap: () => onSelect(index),
                textStyle: TextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? kBackgroundColor : kTextColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
