import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/Features/Home/layout/cubit/states.dart';

import '../../../acount.dart';
import '../../../my_habits.dart';
import '../../home_screen.dart';

class HabitCubit extends Cubit<HabitStates> {
  HabitCubit() : super(HabitInitiateStates());

  static HabitCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    'Home',
    'Mood',
    'My Habits',
    'Account',
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const Text('Mood'),
    MyHabits(),
    Acount(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottonNav());
  }
}
