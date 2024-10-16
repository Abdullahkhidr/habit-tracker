import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/methods/get_date_from_datetime.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/habit_editor_view.dart';
import 'package:habit_tracker/features/my_habits/presentation/manager/habit_details/habit_details_cubit.dart';
import 'package:habit_tracker/features/my_habits/presentation/view/widgets/habit_display_widget.dart';
import 'package:habit_tracker/features/my_habits/presentation/view/widgets/habit_statistics.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailsHabitPage extends StatelessWidget {
  final HabitEntity habit;

  const DetailsHabitPage({super.key, required this.habit});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitDetailsCubit(habit),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverAppBar(
              title: const Text('Details',
                  style: TextStyle(color: kOnSecondaryColor)),
              actions: [
                IconButton(
                  icon: const Icon(HugeIcons.strokeRoundedEdit02),
                  onPressed: () {
                    push(BlocProvider.value(
                            value: locator.get<HabitEditorBloc>(),
                            child: HabitEditorView(habitEntity: habit)))
                        .then((_) {
                      back();
                    });
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: kPaddingMedium, // Use consistent padding
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HabitDisplayWidget(habitEntity: habit),
                      HabitStatistics(habitEntity: habit),
                      BlocBuilder<HabitDetailsCubit, HabitDetailsState>(
                        builder: (context, state) {
                          final bloc = context.read<HabitDetailsCubit>();
                          return Container(
                            margin: kPaddingExtraSmall,
                            decoration: BoxDecoration(
                              color: kBackgroundColor,
                              borderRadius: kBorderRadiusMedium,
                              border: Border.all(color: habit.color),
                              boxShadow: [
                                BoxShadow(
                                  color: habit.color,
                                  blurRadius: kPaddingExtraSmall.left,
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: TableCalendar(
                                firstDay: DateTime(2000, 1, 1),
                                lastDay: DateTime.now(),
                                focusedDay: DateTime.now(),
                                calendarFormat: CalendarFormat.month,
                                calendarStyle:
                                    CalendarStyle(tablePadding: kPaddingMedium),
                                onFormatChanged: (_) {},
                                daysOfWeekHeight: 20.w,
                                calendarBuilders: CalendarBuilders(
                                  dowBuilder: (context, day) => Text(
                                      DateFormat.E().format(day),
                                      textAlign: TextAlign.center,
                                      style: TextStyles.h5.copyWith(
                                          fontWeight: FontWeight.w600)),
                                  headerTitleBuilder: (context, date) => Text(
                                      DateFormat.yMMMM().format(date),
                                      style: TextStyles.h3),
                                  defaultBuilder: (context, day, focusedDay) {
                                    return DetailsCalenderItemWidget(
                                        day: day,
                                        active:
                                            bloc.history.contains(day.date));
                                  },
                                  todayBuilder: (context, day, focusedDay) {
                                    return DetailsCalenderItemWidget(
                                      day: day,
                                      active: bloc.history.contains(day.date),
                                    );
                                  },
                                  disabledBuilder: (context, day, focusedDay) {
                                    return Opacity(
                                      opacity: 0.4,
                                      child: DetailsCalenderItemWidget(
                                          day: day,
                                          active:
                                              bloc.history.contains(day.date)),
                                    );
                                  },
                                  outsideBuilder: (context, day, focusedDay) {
                                    return Opacity(
                                      opacity: 0.5,
                                      child: DetailsCalenderItemWidget(
                                          day: day,
                                          active:
                                              bloc.history.contains(day.date)),
                                    );
                                  },
                                )),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class DetailsCalenderItemWidget extends StatelessWidget {
  final DateTime day;
  final bool active;
  const DetailsCalenderItemWidget(
      {super.key, required this.day, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 30.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: kBorderRadiusCircular,
          color: active ? kPrimaryColor : kHintColor.withOpacity(0.7)),
      child: Text(day.day.toString(),
          style: TextStyles.h4
              .copyWith(color: active ? kOnPrimaryColor : kTextColor)),
    );
  }
}
