import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:habit_tracker/Features/my_habits/widgets/DeleteHabitBottomSheet.dart';
import 'package:habit_tracker/Features/my_habits/widgets/HabitDeletionHandler.dart';
import 'package:habit_tracker/Features/my_habits/widgets/HabitDisplayWidget.dart';
import 'package:habit_tracker/Features/my_habits/widgets/HabitStatistics.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/core/utils/constants.dart';

class EditHabitPage extends StatefulWidget {
  final HabitEntity habit;
  final VoidCallback onHabitDeleted;

  const EditHabitPage({
    Key? key,
    required this.habit,
    required this.onHabitDeleted,
  }) : super(key: key);

  @override
  _EditHabitPageState createState() => _EditHabitPageState();
}

class _EditHabitPageState extends State<EditHabitPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isEditing = false; // Variable to track edit mode

  // Example list of completed days; in a real app, fetch this from storage or state
  List<DateTime> completedDays = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 3)),
    // Add more dates as needed
  ];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.habit.title);
    descriptionController = TextEditingController(text: widget.habit.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveHabit() {
    final updatedHabit = HabitEntity(
      id: widget.habit.id,
      title: titleController.text,
      description: descriptionController.text,
      icon: widget.habit.icon,
      type: widget.habit.type,
      color: widget.habit.color,
      createdAt: widget.habit.createdAt,
      updatedAt: DateTime.now(),
      repeatingType: widget.habit.repeatingType,
      repeatingDays: widget.habit.repeatingDays,
      partOfDay: widget.habit.partOfDay,
      dueDate: widget.habit.dueDate,
      remainder: widget.habit.remainder,
      when: widget.habit.when,
    );

    // Update habit in storage (e.g., Hive, Provider, etc.)
    // For simplicity, assuming it's updated elsewhere

    Navigator.pop(context, updatedHabit);
  }

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing; // Toggle the editing state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Edit Habit', style: TextStyle(color: kOnSecondaryColor)),
              floating: true, // Allows the app bar to be visible while scrolling
              actions: [
                IconButton(
                  icon: Icon(isEditing ? Icons.save : Icons.edit),
                  onPressed: () {
                    if (isEditing) {
                      saveHabit();
                    } else {
                      _toggleEditMode();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteOptionsBottomSheet(context);
                  },
                ),
              ],
            ),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: kPaddingMedium, // Use consistent padding
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HabitDisplayWidget(
                        isEditing: isEditing,
                        titleController: titleController,
                        descriptionController: descriptionController,
                        habitTitle: widget.habit.title, // Pass the title here
                        habitDescription: widget.habit.description, // Pass the description here
                      ),
                    //  Gap(kSpaceMedium),
                      const HabitStatistics(),
                      Gap(kSpaceExtraLarge), 
                      const Text('Calendar Stats', style: TextStyles.h2),
                      Gap(kSpaceLarge),
                      SizedBox(
                        height: 400, // Set a fixed height for the CalendarCarousel
                        child: CalendarCarousel<Event>(
                          todayButtonColor: kPrimaryColor,
                          // todayBorderColor: kPrimaryColor,
                          selectedDayButtonColor: kPrimaryColor,
                          selectedDayBorderColor: kPrimaryColor,
                          weekendTextStyle: const TextStyle(color: kPrimaryColor),
                          weekdayTextStyle: const TextStyle(color: kPrimaryColor),
                          thisMonthDayBorderColor: Colors.grey,
                          selectedDateTime: DateTime.now(),
                          daysHaveCircularBorder: true,
                          markedDatesMap: _getMarkedDates(completedDays),
                          markedDateShowIcon: true,
                          markedDateIconBuilder: (event) {
                            return Container(
                              width: 50,  // Set the width
                              height: 50,  // Set the height
                              decoration: BoxDecoration(
                                color: event.title == 'Completed' ? const Color.fromARGB(113, 0, 125, 167) : Colors.red[200],
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to get marked dates for the calendar
  EventList<Event> _getMarkedDates(List<DateTime> completedDays) {
    final markedDates = EventList<Event>(
      events: {
        for (var day in completedDays)
          DateTime(day.year, day.month, day.day): [Event(date: day, title: 'Completed')],
      },
    );
    return markedDates;
  }

  void _showDeleteOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)), // Use consistent border radius
      ),
      builder: (BuildContext context) {
        return DeleteHabitBottomSheet(
          onDelete: (keepHistory) {
            HabitDeletionHandler(
              context: context,
              onHabitDeleted: widget.onHabitDeleted,
            ).deleteHabit(keepHistory: keepHistory);
          },
        );
      },
    );
  }
}
