import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/errors/failure.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';

abstract class HabitEditorRepository {
  Future<Either<Failure, void>> createHabit(HabitEntity habitEntity);
  Future<Either<Failure, void>> updateHabit(HabitEntity habitEntity);
  Future<Either<Failure, void>> deleteHabit(HabitEntity habitEntity);
}
