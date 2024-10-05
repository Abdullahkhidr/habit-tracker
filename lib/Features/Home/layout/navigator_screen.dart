import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/habit_editor_view.dart';
import 'package:hugeicons/hugeicons.dart';

import 'cubit/home_cubit.dart';

class NavigatorScreen extends StatelessWidget {
  const NavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<HomeCubit>();
    return Scaffold(
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) => cubit.changeBottomNav(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(HugeIcons.strokeRoundedHome01),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(HugeIcons.strokeRoundedSmileDizzy),
              label: 'Mood',
            ),
            BottomNavigationBarItem(
              icon: Icon(HugeIcons.strokeRoundedTaskDaily02),
              label: 'My Habits',
            ),
            BottomNavigationBarItem(
              icon: Icon(HugeIcons.strokeRoundedUserAccount),
              label: 'Account',
            ),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton.small(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          onPressed: () {
            push(BlocProvider(
                create: (context) => locator.get<HabitEditorBloc>(),
                child: const HabitEditorView()));
          },
          child: const Icon(HugeIcons.strokeRoundedTaskEdit02),
        ));
  }
}
