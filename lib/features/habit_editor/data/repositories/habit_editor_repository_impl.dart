import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/errors/failure.dart';
import 'package:habit_tracker/features/habit_editor/data/data_source/local/local_data_source.dart';
import 'package:habit_tracker/features/habit_editor/domain/entities/habit_entity.dart';
import 'package:habit_tracker/features/habit_editor/domain/repositories/habit_editor_repository.dart';

class HabitEditorRepositoryImpl implements HabitEditorRepository {
  final HabitEditorLocalDataSource habitEditorLocalDataSource;

  HabitEditorRepositoryImpl({required this.habitEditorLocalDataSource});
  @override
  Future<Either<Failure, void>> createHabit(HabitEntity habitEntity) async {
    try {
      await habitEditorLocalDataSource.createHabit(habitEntity);
      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHabit(HabitEntity habitEntity) async {
    try {
      await habitEditorLocalDataSource.deleteHabit(habitEntity);
      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHabit(HabitEntity habitEntity) async {
    try {
      await habitEditorLocalDataSource.editHabit(habitEntity);
      return right(null);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
