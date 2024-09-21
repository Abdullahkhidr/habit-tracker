
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LayoutScreen  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitCubit,HabitStates>(
      listener:( context,  state){

      } ,
      builder: (BuildContext context, HabitStates state) {
        var cubit=HabitCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
           // backgroundColor:Colors.pink,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon:Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.add_box_outlined),
                label: 'Create',
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.grid_view),
                label: 'My Habits',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),

            ],
          ),
        );
      },
    );
  }
}