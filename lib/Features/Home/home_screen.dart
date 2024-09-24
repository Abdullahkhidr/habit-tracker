import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('${completedHabits.last.label} marked as complete')),
    );
  }

  void deleteHabit(int index) {
    setState(() {
      habits.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Habit deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: kPaddingSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
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
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(partOfDayFilters.length, (index) {
                return PartOfDayFilterButton(
                  label: partOfDayFilters[index],
                  selected: selectedTimeFilterIndex == index,
                  onTap: () {
                    setState(() {
                      selectedTimeFilterIndex = index;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length + 1,
                itemBuilder: (context, index) {
                  if (index < habits.length) {
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
                      child: HabitCard(
                        label: habits[index].label,
                        color: habits[index].color,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Completed'),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        ...completedHabits.map((habit) {
                          return CompletedCard(
                            label: habit.label,
                            icon: Icons.check_circle,
                            color: Colors.green.shade200,
                          );
                        }),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationFilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const DurationFilterButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: selected ? Colors.white : Colors.black,
        backgroundColor: selected ? kPrimaryColor : kHintColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(label),
    );
  }
}

class PartOfDayFilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const PartOfDayFilterButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        minimumSize: Size(60.w, 30.h),
        foregroundColor: selected ? Colors.white : Colors.black,
        backgroundColor: selected ? kPrimaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: selected ? Colors.transparent : kHintColor,
            width: 1.w,
          ),
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 14.sp)),
    );
  }
}

class Habit {
  final String label;
  final Color color;

  Habit({required this.label, required this.color});
}

class HabitCard extends StatelessWidget {
  final String label;
  final Color color;

  const HabitCard({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        contentPadding: kPaddingExtraSmall.copyWith(
            left: kPaddingMedium.left, right: kPaddingMedium.right),
        title: Text(
          label,
          style: TextStyle(
            color: kTextColor,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}

class CompletedCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const CompletedCard({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(label),
        trailing: Icon(icon, color: Colors.green),
      ),
    );
  }
}
