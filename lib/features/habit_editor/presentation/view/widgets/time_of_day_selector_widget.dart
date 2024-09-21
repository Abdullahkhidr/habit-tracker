import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class TimeOfDaySelectorWidget extends StatelessWidget {
  const TimeOfDaySelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          _dayParts.length,
          (index) => Expanded(
                child: Padding(
                  padding: (index != 0 && index != _dayParts.length - 1)
                      ? kPaddingSmall
                      : EdgeInsets.zero,
                  child: OptionWidget(
                      title: _dayParts[index],
                      isSelected: index == 0,
                      unSelectedBackgroundColor: kBackgroundColor,
                      borderRadius: kBorderRadiusCircular,
                      onSelect: () {}),
                ),
              )),
    );
  }
}

const _dayParts = ["Morning", "Afternoon", "Evening"];
