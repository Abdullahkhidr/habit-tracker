import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/core/methods/show_message.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/Home/widgets/complete_task_item_widget.dart';
import 'package:habit_tracker/features/Home/widgets/filter_time_widget.dart';
import 'package:habit_tracker/features/Home/widgets/part_of_day_filter_button.dart';
import 'package:habit_tracker/features/Home/widgets/task_item_widget.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/part_of_day.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTimeFilterIndex = 0;
  int selectedMainFilterIndex = 0;
  List<HabitEntity> habits = [];
  List<HabitEntity> completedHabits = [];
  List<String> partOfDayFilters = ['All', 'Morning', 'Afternoon', 'Evening'];
  void completeTask(int index) {
    setState(() {
      completedHabits.add(habits[index]);
      habits.removeAt(index);
    });
    showMessage('${completedHabits.last.title} marked as complete',
        messageType: MessageType.success);
  }

  void deleteTask(int index) {
    showMessage('${habits[index].title} deleted',
        messageType: MessageType.warning);
    setState(() {
      habits.removeAt(index);
    });
  }

  @override
  void initState() {
    Box<HabitEntity> box = Hive.box<HabitEntity>(HiveHelper.habitBox);
    habits = box.values.toList();
    super.initState();
  }

  List<HabitEntity> filterHabits() {
    if (partOfDayFilters[selectedTimeFilterIndex] == 'Morning') {
      return habits
          .where((habit) => habit.partOfDay == PartOfDay.morning)
          .toList();
    } else if (partOfDayFilters[selectedTimeFilterIndex] == 'Afternoon') {
      return habits
          .where((habit) => habit.partOfDay == PartOfDay.afternoon)
          .toList();
    } else if (partOfDayFilters[selectedTimeFilterIndex] == 'Evening') {
      return habits
          .where((habit) => habit.partOfDay == PartOfDay.evening)
          .toList();
    }
    return habits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kPaddingSmall,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text('Home')),
            SliverToBoxAdapter(
                child: FilterTimeWidget(
                    selectedMainFilterIndex: selectedMainFilterIndex,
                    onSelect: (selected) {
                      setState(() {
                        selectedMainFilterIndex = selected;
                      });
                    })),
            SliverToBoxAdapter(child: Gap(kSpaceLarge)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(partOfDayFilters.length, (index) {
                  return Expanded(
                    child: PartOfDayFilterButton(
                      label: partOfDayFilters[index],
                      selected: selectedTimeFilterIndex == index,
                      onTap: () {
                        setState(() {
                          selectedTimeFilterIndex = index;
                        });
                      },
                    ),
                  );
                }),
              ),
            ),
            SliverToBoxAdapter(child: Gap(kSpaceLarge)),
            SliverList.builder(
              itemCount: filterHabits().length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: kPaddingExtraSmall,
                  child: Slidable(
                    closeOnScroll: true,
                    startActionPane: TaskActionWidget(
                        icon: HugeIcons.strokeRoundedTaskDone02,
                        action: () => completeTask(index),
                        backgroundColor: kSuccessColor),
                    endActionPane: TaskActionWidget(
                        icon: HugeIcons.strokeRoundedDelete02,
                        action: () => deleteTask(index),
                        backgroundColor: kErrorColor),
                    child: TaskItemWidget(habitEntity: filterHabits()[index]),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(child: Gap(kSpaceLarge)),
            SliverToBoxAdapter(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container(height: 1, color: Colors.grey)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Completed'),
                ),
                Expanded(child: Container(height: 1, color: Colors.grey)),
              ],
            )),
            SliverToBoxAdapter(child: Gap(kSpaceLarge)),
            SliverList.builder(
              itemCount: completedHabits.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: kPaddingExtraSmall,
                  child: CompletedTaskItemWidget(
                      habitEntity: completedHabits[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
