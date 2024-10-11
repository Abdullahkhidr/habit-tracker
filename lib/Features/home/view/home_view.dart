import 'package:flutter/material.dart';
import 'package:habit_tracker/Features/home/view/widgets/filter_time_widget.dart';
import 'package:habit_tracker/core/utils/constants.dart';

import 'today_view.dart';
import 'weekly_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                children: const [
                  TodayView(),
                  WeeklyView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
