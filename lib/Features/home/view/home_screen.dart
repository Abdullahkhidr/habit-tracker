import 'package:flutter/material.dart';
import 'package:habit_tracker/Features/home/view/widgets/filter_time_widget.dart';
import 'package:habit_tracker/core/utils/constants.dart';

import '../today/today.dart';
import '../weekly/weekly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedMainFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: kPaddingSmall,
        child: Column(
          children: [
            FilterTimeWidget(
              selectedMainFilterIndex: selectedMainFilterIndex,
              onSelect: (selected) {
                setState(() {
                  selectedMainFilterIndex = selected;
                });
              },
            ),
            Expanded(
              child: IndexedStack(
                index: selectedMainFilterIndex,
                children: [
                  TodayScreen(),
                  WeeklyScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
