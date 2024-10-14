import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/features/home/manager/weekly/weekly_cubit.dart';
import 'package:habit_tracker/features/home/view/widgets/habit_week_card_widget.dart';
import '../../../core/utils/constants.dart';

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator.get<WeeklyCubit>(),
      child: Scaffold(
        body: BlocBuilder<WeeklyCubit, WeeklyState>(
          builder: (context, state) {
            final bloc = context.watch<WeeklyCubit>();
            return ListView.builder(
              padding: kPaddingMedium,
              itemBuilder: (context, index) => HabitWeekCardWidget(
                habit: bloc.habits[index],
              ),
              itemCount: bloc.habits.length,
            );
          },
        ),
      ),
    );
  }
}
