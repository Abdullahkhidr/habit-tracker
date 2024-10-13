import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/features/mood/presentation/manager/mood_tracker/mood_tracker_cubit.dart';
import 'package:habit_tracker/features/mood/presentation/view/widgets/custom_mood_view_app_bar.dart';
import 'package:habit_tracker/features/mood/presentation/view/widgets/mood_view_body.dart';

class MoodView extends StatelessWidget {
  const MoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator.get<MoodTrackerCubit>(),
      child: const Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: CustomMoodViewAppBar()),
              SliverToBoxAdapter(child: MoodViewBody()),
            ],
          ),
        ),
      ),
    );
  }
}
