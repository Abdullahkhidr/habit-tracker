import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/repeat_type.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/choose_days_of_month_widget.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/widgets/choose_days_of_week_widget.dart';

class RepeatSectionWidget extends StatelessWidget {
  const RepeatSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitEditorBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // const Text('Repeat', style: TextStyles.h3),
        // Gap(kSpaceMedium),
        // const TypeOfRepeatSelectorWidget(),
        // Gap(kSpaceMedium),
        if (bloc.habitEntity.repeatingType == RepeatType.weekly)
          const ChooseDaysOfWeekWidget()
        else
          const ChooseDaysOfMonthWidget(),
      ],
    );
  }
}
