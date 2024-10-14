import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/habit_editor_view.dart';
import 'package:habit_tracker/features/home/manager/today/today_habits_cubit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../core/methods/navigation.dart';
import '../../../core/utils/constants.dart';
import 'widgets/complete_task_item_widget.dart';
import 'widgets/part_of_day_filter_button.dart';
import 'widgets/task_item_widget.dart';

class TodayView extends StatefulWidget {
  const TodayView({super.key});

  @override
  _TodayViewState createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  int selectedTimeFilterIndex = 0;
  List<String> partOfDayFilters = ['All', 'Morning', 'Afternoon', 'Evening'];

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: locator.get<TodayHabitsCubit>(),
      child: Scaffold(
        body: Padding(
          padding: kPaddingMedium.copyWith(top: 0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: Gap(kSpaceLarge)),
              SliverToBoxAdapter(
                child: BlocBuilder<TodayHabitsCubit, TodayHabitsState>(
                  builder: (context, state) {
                    final bloc = context.read<TodayHabitsCubit>();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(partOfDayFilters.length, (index) {
                        return Expanded(
                          child: PartOfDayFilterButton(
                            label: partOfDayFilters[index],
                            selected: selectedTimeFilterIndex == index,
                            onTap: () {
                              setState(() {
                                selectedTimeFilterIndex = index;
                                if (selectedTimeFilterIndex == 0) {
                                  bloc.filterByPartOfDay(null);
                                } else if (selectedTimeFilterIndex == 1) {
                                  bloc.filterByPartOfDay(PartOfDay.morning);
                                } else if (selectedTimeFilterIndex == 2) {
                                  bloc.filterByPartOfDay(PartOfDay.afternoon);
                                } else if (selectedTimeFilterIndex == 3) {
                                  bloc.filterByPartOfDay(PartOfDay.evening);
                                }
                              });
                            },
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: Gap(kSpaceLarge)),
              BlocBuilder<TodayHabitsCubit, TodayHabitsState>(
                builder: (context, state) {
                  final bloc = context.watch<TodayHabitsCubit>();
                  if (bloc.inCompletedHabits.isEmpty &&
                      bloc.completedHabits.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                          child: Lottie.asset('assets/lottie/playing.json')),
                    );
                  }
                  return SliverList.builder(
                    itemCount: bloc.inCompletedHabits.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: kPaddingExtraSmall,
                        child: Slidable(
                          closeOnScroll: true,
                          startActionPane: TaskActionWidget(
                              icon: HugeIcons.strokeRoundedTaskDone02,
                              action: () => bloc
                                  .taskCompleted(bloc.inCompletedHabits[index]),
                              backgroundColor: kSuccessColor),
                          endActionPane: TaskActionWidget(
                              icon: HugeIcons.strokeRoundedEdit02,
                              action: () {
                                push(BlocProvider.value(
                                    value: locator.get<HabitEditorBloc>(),
                                    child: HabitEditorView(
                                        habitEntity:
                                            bloc.inCompletedHabits[index])));
                              },
                              backgroundColor: Colors.amber),
                          child: TaskItemWidget(
                            onTap: () {},
                            habitEntity: bloc.inCompletedHabits[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SliverToBoxAdapter(child: Gap(kSpaceLarge)),
              BlocBuilder<TodayHabitsCubit, TodayHabitsState>(
                builder: (context, state) {
                  final bloc = context.read<TodayHabitsCubit>();
                  if (bloc.completedHabits.isEmpty) {
                    return const SliverToBoxAdapter();
                  }
                  return SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(height: 1, color: Colors.grey)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Completed'),
                        ),
                        Expanded(
                            child: Container(height: 1, color: Colors.grey)),
                      ],
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(child: Gap(kSpaceLarge)),
              BlocBuilder<TodayHabitsCubit, TodayHabitsState>(
                builder: (context, state) {
                  final bloc = context.read<TodayHabitsCubit>();
                  return SliverList.builder(
                    itemCount: bloc.completedHabits.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: kPaddingExtraSmall,
                        child: CompletedTaskItemWidget(
                          onUndo: (habit) {
                            bloc.undoTask(habit);
                          },
                          habitEntity: bloc.completedHabits[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
