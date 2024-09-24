import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class NavigatorScreen extends StatelessWidget {
  const NavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<HabitCubit>();
    return Scaffold(
      body: cubit.screens[cubit.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.currentIndex,
        onTap: (index) => cubit.changeBottomNav(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'My Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
