import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/Features/Home/layout/cubit/states.dart';

import '../../../acount.dart';
import '../../../my_habits.dart';
import '../../../new_habit.dart';
import '../../home_screen.dart';

class HabitCubit extends Cubit<HabitStates> {


  HabitCubit() : super(HabitInitiateStates());

  static HabitCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;

  List<String> titles = [
    'Home',
    'Create',
    'My Habits',
    'Account',

  ];
  List<Widget> screens = [
    HomeScreen(),
    CreateHabit(),
    MyHabits(),
    Acount(),

  ];

  void changeBottomNav(int index) {
      currentIndex = index;
      emit(ChangeBottonNav());

  }


  }

