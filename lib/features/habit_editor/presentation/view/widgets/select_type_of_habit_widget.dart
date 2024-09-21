import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class SelectTypeOfHabitWidget extends StatelessWidget {
  const SelectTypeOfHabitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: OptionWidget(
              title: 'Regular Habit', isSelected: true, onSelect: () {})),
      const Gap(kSpaceSmall),
      Expanded(
          child: OptionWidget(
              title: 'On-Time Task', isSelected: false, onSelect: () {})),
    ]);
  }
}
