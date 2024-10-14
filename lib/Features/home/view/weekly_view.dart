import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/home/manager/weekly/weekly_cubit.dart';
import 'package:habit_tracker/features/home/view/widgets/habit_week_card_widget.dart';
import 'package:lottie/lottie.dart';
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
            if (bloc.habits.isEmpty) {
              return Column(
                children: [
                  Lottie.asset('assets/lottie/playing.json'),
                  Text('There is no any task in the current week',
                      style: TextStyles.b3.copyWith(color: kSecondaryColor))
                ],
              );
            }
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
