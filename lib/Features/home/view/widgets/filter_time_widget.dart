import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
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
    return Row(
      children: List.generate(timeFilters.length, (index) {
        bool isSelected = selectedMainFilterIndex == index;
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? kPrimaryColor : kHintColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: DurationFilterButton(
              label: timeFilters[index],
              selected: isSelected,
              onTap: () => onSelect(index),
              textStyle: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
                color: isSelected ? kBackgroundColor : kTextColor,
              ),
            ),
          ),
        );
      }),
    );
  }
}
