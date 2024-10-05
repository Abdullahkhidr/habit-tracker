import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/features/acount.dart';
import 'package:habit_tracker/features/habit_editor/presentation/manager/habit_editor/habit_editor_bloc.dart';
import 'package:habit_tracker/features/habit_editor/presentation/view/habit_editor_view.dart';
import 'package:habit_tracker/features/home/view/home_screen.dart';
import 'package:habit_tracker/features/my_habits/my_habits.dart';
import 'package:hugeicons/hugeicons.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const Text('Mood'),
    const MyHabits(),
    Acount(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => {
            setState(() {
              currentIndex = index;
            })
          },
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
            push(BlocProvider.value(
                value: locator.get<HabitEditorBloc>(),
                child: const HabitEditorView()));
          },
          child: const Icon(HugeIcons.strokeRoundedTaskEdit02),
        ));
  }
}
