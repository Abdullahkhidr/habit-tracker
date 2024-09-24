import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/core/methods/show_message.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/Home/widgets/complete_task_item_widget.dart';
import 'package:habit_tracker/features/Home/widgets/duration_filter_button.dart';
import 'package:habit_tracker/features/Home/widgets/part_of_day_filter_button.dart';
import 'package:habit_tracker/features/Home/widgets/task_item_widget.dart';

import '../../core/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTimeFilterIndex = 0;
  int selectedMainFilterIndex = 0;

  List<Habit> habits = [
    Habit(label: 'Set Small Goals', color: Colors.pink.shade200),
    Habit(label: 'Work', color: Colors.purple.shade200),
    Habit(label: 'Meditation', color: Colors.green.shade200),
    Habit(label: 'Basketball', color: Colors.orange.shade200),
  ];

  List<Habit> completedHabits = [
    Habit(label: 'Set Small Goals', color: Colors.pink.shade200),
    Habit(label: 'Work', color: Colors.purple.shade200),
  ];
  List<String> timeFilters = ['Today', 'Weekly', 'Overall'];
  List<String> partOfDayFilters = ['All', 'Morning', 'Afternoon', 'Evening'];

  void completeHabit(int index) {
    setState(() {
      completedHabits.add(habits[index]);
      habits.removeAt(index);
    });
    showMessage('${completedHabits.last.label} marked as complete',
        messageType: MessageType.success);
  }

  void deleteHabit(int index) {
    setState(() {
      habits.removeAt(index);
    });
    showMessage('${habits[index].label} deleted',
        messageType: MessageType.warning);
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
              child: Row(
                children: List.generate(timeFilters.length, (index) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedMainFilterIndex == index
                            ? kPrimaryColor
                            : kHintColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: DurationFilterButton(
                        label: timeFilters[index],
                        selected: selectedMainFilterIndex == index,
                        onTap: () {
                          setState(() {
                            selectedMainFilterIndex = index;
                          });
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
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
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => completeHabit(index),
                        backgroundColor: Colors.green,
                        borderRadius: BorderRadius.circular(16.r),
                        foregroundColor: Colors.white,
                        icon: Icons.check,
                        label: 'Complete',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => deleteHabit(index),
                        backgroundColor: Colors.red,
                        borderRadius: BorderRadius.circular(16.r),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: TaskItemWidget(
                    label: habits[index].label,
                    color: habits[index].color,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(child: Gap(kSpaceLarge)),
            SliverToBoxAdapter(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container(height: 1, color: Colors.grey)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Completed'),
                    ),
                    Expanded(child: Container(height: 1, color: Colors.grey)),
                  ],
                ),
              ],
            )),
            SliverToBoxAdapter(child: Gap(kSpaceLarge)),
            SliverList.builder(
                itemCount: completedHabits.length,
                itemBuilder: (context, index) {
                  return CompleteTaskItemWidget(
                    label: completedHabits[index].label,
                    icon: Icons.check_circle,
                    color: Colors.green.shade200,
                  );
                })
          ],
        ),
      ),
    );
  }
}

class Habit {
  final String label;
  final Color color;

  Habit({required this.label, required this.color});
}
