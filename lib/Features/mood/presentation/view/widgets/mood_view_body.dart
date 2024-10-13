import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/mood/presentation/manager/mood_tracker/mood_tracker_cubit.dart';
import 'package:habit_tracker/features/mood/presentation/view/widgets/mood_calender_day_widget.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MoodViewBody extends StatelessWidget {
  const MoodViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: kPaddingMedium,
        decoration: BoxDecoration(
            color: kHintColor.withOpacity(0.5),
            borderRadius: kBorderRadiusLarge),
        child: BlocBuilder<MoodTrackerCubit, MoodTrackerState>(
          builder: (context, state) {
            final bloc = context.read<MoodTrackerCubit>();
            return TableCalendar(
                firstDay: DateTime(2000, 1, 1),
                lastDay: DateTime.now(),
                focusedDay: bloc.lastSelectedDate,
                calendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(tablePadding: kPaddingMedium),
                onPageChanged: (focusedDay) {
                  bloc.lastSelectedDate = focusedDay;
                },
                onFormatChanged: (_) {},
                rowHeight: 90.w,
                daysOfWeekHeight: 20.w,
                calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) => Text(
                        DateFormat.E().format(day),
                        textAlign: TextAlign.center,
                        style: TextStyles.h5
                            .copyWith(fontWeight: FontWeight.w600)),
                    headerTitleBuilder: (context, date) => Text(
                        DateFormat.yMMMM().format(date),
                        style: TextStyles.h3),
                    outsideBuilder: (context, day, focusedDay) {
                      var currentDay = bloc.moods.where((e) => e.date == day);
                      return Opacity(
                          opacity: 0.4,
                          child: MoodCalenderDayWidget(
                            date: day,
                            moodEntity:
                                currentDay.isNotEmpty ? currentDay.first : null,
                          ));
                    },
                    defaultBuilder: (context, day, focusedDay) {
                      var currentDay = bloc.moods.where((e) => e.date == day);
                      return MoodCalenderDayWidget(
                          date: day,
                          onTap: (date) => bloc.setMood(date),
                          moodEntity:
                              currentDay.isNotEmpty ? currentDay.first : null);
                    },
                    disabledBuilder: (context, day, focusedDay) {
                      var currentDay = bloc.moods.where((e) => e.date == day);
                      return Opacity(
                          opacity: 0.9,
                          child: MoodCalenderDayWidget(
                              date: day,
                              moodEntity: currentDay.isNotEmpty
                                  ? currentDay.first
                                  : null));
                    },
                    todayBuilder: (context, day, focusedDay) {
                      var currentDay = bloc.moods.where((e) => e.date == day);
                      return MoodCalenderDayWidget(
                          date: day,
                          moodEntity:
                              currentDay.isNotEmpty ? currentDay.first : null,
                          onTap: (date) => bloc.setMood(date));
                    }));
          },
        ));
  }
}
