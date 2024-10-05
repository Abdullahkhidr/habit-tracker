import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/core/widgets/gap.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/habit_editor_view.dart';
import 'package:habit_tracker/features/my_habits/widgets/delete_habit_bottom_sheet.dart';
import 'package:habit_tracker/features/my_habits/widgets/habit_deletion_handler.dart';
import 'package:habit_tracker/features/my_habits/widgets/habit_display_widget.dart';
import 'package:habit_tracker/features/my_habits/widgets/habit_statistics.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class DetailsHabitPage extends StatefulWidget {
  final HabitEntity habit;
  final VoidCallback onHabitDeleted;

  const DetailsHabitPage({
    super.key,
    required this.habit,
    required this.onHabitDeleted,
  });

  @override
  _DetailsHabitPageState createState() => _DetailsHabitPageState();
}

class _DetailsHabitPageState extends State<DetailsHabitPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isEditing = false; // Variable to track edit mode

  // Example list of completed days; in a real app, fetch this from storage or state
  List<DateTime> completedDays = [
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 3)),
    DateTime.now().subtract(const Duration(days: 6)),
    DateTime.now().add(const Duration(days: 9)),
    DateTime.now().add(const Duration(days: 13)),
    // Add more dates as needed
  ];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.habit.title);
    descriptionController =
        TextEditingController(text: widget.habit.description);
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
              title: const Text('Details',
                  style: TextStyle(color: kOnSecondaryColor)),
              actions: [
                IconButton(
                  icon: const Icon(HugeIcons.strokeRoundedEdit02),
                  onPressed: () {
                    push(Provider.value(
                        value: locator.get<HabitEditorBloc>(),
                        child: HabitEditorView(habitEntity: widget.habit)));
                  },
                ),
                IconButton(
                  icon: const Icon(HugeIcons.strokeRoundedDelete02,
                      color: kErrorColor),
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
                      HabitDisplayWidget(habitEntity: widget.habit),
                      //  Gap(kSpaceMedium),
                      HabitStatistics(habitEntity: widget.habit),
                      Gap(kSpaceExtraLarge),
                      const Text('Calendar Stats', style: TextStyles.h2),
                      Gap(kSpaceLarge),
                      SizedBox(
                        height:
                            400, // Set a fixed height for the CalendarCarousel
                        child: CalendarCarousel<Event>(
                          // todayButtonColor: kPrimaryColor,
                          // todayBorderColor: kPrimaryColor,
                          daysTextStyle: GoogleFonts.cairo(
                              color: kTextColor, fontWeight: FontWeight.bold),
                          weekendTextStyle: GoogleFonts.cairo(
                              color: kTextColor, fontWeight: FontWeight.bold),
                          headerTextStyle: GoogleFonts.cairo(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: TextStyles.h2.fontSize),
                          weekdayTextStyle: GoogleFonts.cairo(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                          thisMonthDayBorderColor: kHintColor,
                          selectedDayButtonColor: kPrimaryColor,
                          selectedDayBorderColor: kPrimaryColor,
                          todayTextStyle: GoogleFonts.cairo(
                              color: kOnPrimaryColor,
                              fontWeight: FontWeight.bold),
                          selectedDateTime: DateTime.now(),
                          daysHaveCircularBorder: true,
                          markedDatesMap: _getMarkedDates(completedDays),
                          markedDateShowIcon: true,
                          markedDateIconBuilder: (event) {
                            return Container(
                              decoration: BoxDecoration(
                                color: event.title == 'Completed'
                                    ? const Color(0x70007DA7)
                                    : Colors.red[200],
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
          DateTime(day.year, day.month, day.day): [
            Event(date: day, title: 'Completed')
          ],
      },
    );
    return markedDates;
  }

  void _showDeleteOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16)), // Use consistent border radius
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
