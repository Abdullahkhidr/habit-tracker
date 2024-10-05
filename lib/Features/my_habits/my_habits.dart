import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/home/view/widgets/task_item_widget.dart';
import 'package:habit_tracker/features/my_habits/edit_habit_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHabits extends StatefulWidget {
  const MyHabits({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHabitsState createState() => _MyHabitsState();
}

class _MyHabitsState extends State<MyHabits> {
  late Box<HabitEntity> box;
  List<HabitEntity> habits = [];

  @override
  void initState() {
    super.initState();
    box = Hive.box<HabitEntity>(HiveHelper.habitBox);
    habits = box.values.toList();
  }

  void _deleteHabit(int index) {
    setState(() {
      box.delete(habits[index].id); // Delete from Hive
      habits.removeAt(index); // Remove from local list
    });
    // _showSnackBarMessage('Habit successfully deleted', success: true);
  }

  void editHabit(int index) async {
    final updatedHabit = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditHabitPage(
          habit: habits[index],
          onHabitDeleted: () {
            _deleteHabit(index);
          },
        ),
      ),
    );

    if (updatedHabit != null) {
      setState(() {
        habits[index] = updatedHabit;
        box.put(
            updatedHabit.id, updatedHabit); // Update the habit in the Hive box
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
            const SliverAppBar(
              title: Text('My Habits'),
              floating: true,
              pinned: true,
            ),
            SliverToBoxAdapter(child: Gap(kSpaceLarge)),
            habits.isEmpty
                ? const SliverFillRemaining(
                    child: Center(child: Text('No habits found.')))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final habit = habits[index];
                        return Padding(
                          padding: kPaddingExtraSmall,
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) => editHabit(index),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ],
                            ),
                            child: TaskItemWidget(
                                habitEntity: habit, isCompleted: false),
                          ),
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
