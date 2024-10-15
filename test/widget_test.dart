import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/my_habits/presentation/manager/habit_details/habit_details_cubit.dart';

void main() {
  group("Percentage Complete", () {
    var habit = HabitEntity.empty();
    test("Should return 100 when all days are completed", () {
      habit.repeatingDays = {1, 2, 3, 4, 5, 6, 7};
      var start = DateTime.now().subtract(const Duration(days: 10));
      habit.createdAt = DateTime(start.year, start.month, start.day);
      HabitDetailsCubit cubit = HabitDetailsCubit(habit);
      DateTime now = DateTime.now();
      cubit.history = [
        for (var i = 0; i <= 10; i++)
          DateTime(now.year, now.month, now.day)
              .subtract(Duration(days: 10 - i)),
      ];
      print(cubit.history);
      expect(cubit.numberOfDays, 100.0);
    });
  });
}
