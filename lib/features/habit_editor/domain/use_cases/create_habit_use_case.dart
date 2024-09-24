import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/errors/failure.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/repositories/habit_editor_repository.dart';

class CreateHabitUseCase {
  final HabitEditorRepository repository;

  CreateHabitUseCase({required this.repository});

  Future<Either<Failure, void>> call(HabitEntity habitEntity) async {
    return await repository.createHabit(habitEntity);
  }
}
