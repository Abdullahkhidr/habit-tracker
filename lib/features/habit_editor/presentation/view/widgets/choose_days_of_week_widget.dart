import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class ChooseDaysOfWeekWidget extends StatefulWidget {
  final Function(Set<int> selected) onChangeSelectionDays;
  const ChooseDaysOfWeekWidget(
      {super.key, required this.onChangeSelectionDays});

  @override
  State<ChooseDaysOfWeekWidget> createState() => _ChooseDaysOfWeekWidgetState();
}

class _ChooseDaysOfWeekWidgetState extends State<ChooseDaysOfWeekWidget> {
  final Set<int> days = {};
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
            value: days.length == 7,
            onChanged: (value) {
              if (days.length == 7) {
                days.clear();
              } else {
                days.addAll(List.generate(7, (index) => index + 1));
              }
              setState(() {});
              widget.onChangeSelectionDays(days);
            }),
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
                          isSelected: days.contains(index + 1),
                          onSelect: () {
                            if (days.contains(index + 1)) {
                              days.remove(index + 1);
                            } else {
                              days.add(index + 1);
                            }
                            setState(() {});
                            widget.onChangeSelectionDays(days);
                          }),
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
