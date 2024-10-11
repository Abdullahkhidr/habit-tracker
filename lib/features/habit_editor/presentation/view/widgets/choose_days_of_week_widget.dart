import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class ChooseDaysOfWeekWidget extends StatelessWidget {
  const ChooseDaysOfWeekWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
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
            value: bloc.habitEntity.repeatingDays.length == 7,
            onChanged: (value) {
              if (bloc.habitEntity.repeatingDays.length == 7) {
                bloc.habitEntity.repeatingDays.clear();
              } else {
                bloc.habitEntity.repeatingDays
                    .addAll(List.generate(7, (index) => index + 1));
              }
              bloc.add(HabitEditorRepeatDaysSelectedEvent(
                  days: bloc.habitEntity.repeatingDays));
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
                          isSelected: bloc.habitEntity.repeatingDays
                              .contains(index + 1),
                          onSelect: () {
                            if (bloc.habitEntity.repeatingDays
                                .contains(index + 1)) {
                              bloc.habitEntity.repeatingDays.remove(index + 1);
                            } else {
                              bloc.habitEntity.repeatingDays.add(index + 1);
                            }
                            bloc.add(HabitEditorRepeatDaysSelectedEvent(
                                days: bloc.habitEntity.repeatingDays));
                          }),
                    ))))
      ],
    );
  }
}

const _days = ["M", "T", "W", "T", "F", "S", "S"];
