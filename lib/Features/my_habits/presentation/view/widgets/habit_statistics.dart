import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/my_habits/presentation/manager/habit_details/habit_details_cubit.dart';

class HabitStatistics extends StatelessWidget {
  final HabitEntity habitEntity;
  const HabitStatistics({super.key, required this.habitEntity});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HabitDetailsCubit>();
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: kPaddingMedium.left, horizontal: kPaddingExtraSmall.top),
      child: Column(
        children: [
          StatisticsCard(
            value: '${bloc.currentStreak} days',
            label: 'Current streak',
            color: habitEntity.color,
          ),
          StatisticsCard(
              value: '${bloc.completionRate * 100}%',
              label: 'Completion rate',
              trailing: CircularProgressIndicator(
                value: bloc.completionRate,
                backgroundColor: kHintColor,
                strokeWidth: 8,
                color: habitEntity.color
              ),
              color: habitEntity.color),
          StatisticsCard(
              value: '${bloc.numberOfDays.completed}',
              label: 'Habits completed',
              color: habitEntity.color),
        ],
      ),
    );
  }
}

class StatisticsCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final Widget? trailing;
  const StatisticsCard({
    super.key,
    required this.value,
    required this.label,
    required this.color,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPaddingExtraSmall.copyWith(left: 0, right: 0),
      child: ListTile(
          tileColor: kBackgroundColor,
          trailing: trailing,
          shape: RoundedRectangleBorder(
              borderRadius: kBorderRadiusSmall, side: BorderSide(color: color)),
          title: Text(value, style: TextStyles.h2),
          subtitle: Text(label)),
    );
  }
}
