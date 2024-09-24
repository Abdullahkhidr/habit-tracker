import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/Home/widgets/duration_filter_button.dart';

class FilterTimeWidget extends StatelessWidget {
  final int selectedMainFilterIndex;
  final Function(int) onSelect;
  const FilterTimeWidget(
      {super.key,
      required this.selectedMainFilterIndex,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final List<String> timeFilters = ['Today', 'Weekly', 'Overall'];
    return Row(
      children: List.generate(timeFilters.length, (index) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color:
                  selectedMainFilterIndex == index ? kPrimaryColor : kHintColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DurationFilterButton(
                label: timeFilters[index],
                selected: selectedMainFilterIndex == index,
                onTap: () => onSelect(index)),
          ),
        );
      }),
    );
  }
}
