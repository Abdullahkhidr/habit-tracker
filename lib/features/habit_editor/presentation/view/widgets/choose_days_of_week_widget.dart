import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class ChooseDaysOfWeekWidget extends StatelessWidget {
  const ChooseDaysOfWeekWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('On these days: ', style: TextStyles.h3),
                Text('All Days', style: TextStyles.b5)
              ],
            ),
            value: true,
            onChanged: (value) {}),
        Row(
            children: List.generate(
                _days.length,
                (index) => Expanded(
                        child: Padding(
                      padding: (index != 0 && index != _days.length - 1)
                          ? kPaddingExtraSmall
                          : EdgeInsets.zero,
                      child: OptionWidget(
                          title: _days[index],
                          isSelected: index != 1,
                          onSelect: () {}),
                    ))))
      ],
    );
  }
}

const _days = [
  "S",
  "M",
  "T",
  "w",
  "T",
  "F",
  "S",
];
