import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/option_widget.dart';

class ChooseDaysOfMonthWidget extends StatelessWidget {
  const ChooseDaysOfMonthWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return Container(
      padding: kPaddingMedium,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: kHintColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Every month on:',
              style: TextStyles.b3.copyWith(fontWeight: FontWeight.w500)),
          Gap(kSpaceLarge),
          Wrap(
              runSpacing: kPaddingExtraSmall.vertical,
              spacing: kPaddingExtraSmall.horizontal,
              children: List.generate(
                  30,
                  (index) => SizedBox(
                        width: 40,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: OptionWidget(
                              padding: kPaddingExtraSmall,
                              borderRadius: kBorderRadiusCircular,
                              title: '${index + 1}',
                              isSelected: bloc.habitEntity.repeatingDays
                                  .contains(index + 1),
                              onSelect: () {
                                if (bloc.habitEntity.repeatingDays
                                    .contains(index + 1)) {
                                  bloc.habitEntity.repeatingDays
                                      .remove(index + 1);
                                } else {
                                  bloc.habitEntity.repeatingDays.add(index + 1);
                                }
                                bloc.add(HabitEditorRepeatDaysSelectedEvent(
                                    days: bloc.habitEntity.repeatingDays));
                              }),
                        ),
                      ))),
        ],
      ),
    );
  }
}
