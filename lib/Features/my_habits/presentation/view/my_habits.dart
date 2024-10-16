import 'package:flutter/material.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/home/view/widgets/task_item_widget.dart';
import 'package:habit_tracker/features/my_habits/presentation/view/details_habit_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHabits extends StatefulWidget {
  const MyHabits({super.key});

  @override
  _MyHabitsState createState() => _MyHabitsState();
}

class _MyHabitsState extends State<MyHabits> {
  Box<HabitEntity> box = Hive.box<HabitEntity>(HiveHelper.habitBox);
  List<HabitEntity> habits = [];

  @override
  void initState() {
    super.initState();
    habits = box.values.toList();
  }

  void editHabit(int index) async {
    final updatedHabit = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsHabitPage(
          habit: habits[index],
        ),
      ),
    );

    if (updatedHabit != null) {
      setState(() {
        habits[index] = updatedHabit;
        box.put(updatedHabit.id, updatedHabit);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kPaddingSmall,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text('My Habits')),
            SliverToBoxAdapter(child: Gap(kSpaceExtraSmall)),
            habits.isEmpty
                ? const SliverFillRemaining(
                    child: Center(child: Text('No habits found.')))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final habit = habits[index];
                        return Padding(
                          padding: kPaddingSmall.copyWith(bottom: 0),
                          child: TaskItemWidget(
                              onTap: () => editHabit(index),
                              habitEntity: habit,
                              isCompleted: false),
                        );
                      },
                      childCount: habits.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}