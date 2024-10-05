import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/home/layout/cubit/home_states.dart';
import 'package:habit_tracker/features/my_habits/my_habits.dart';

import '../../../acount.dart';
import '../../home_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitiateStates());

  static HomeCubit get(context) => BlocProvider.of(context);

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
    const MyHabits(),
    Acount(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeButtonNav());
  }
}
