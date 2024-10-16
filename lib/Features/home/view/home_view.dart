import 'package:flutter/material.dart';
import 'package:habit_tracker/Features/home/view/widgets/filter_time_widget.dart';

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
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const SliverAppBar(title: Text('Home'), centerTitle: true),
            SliverToBoxAdapter(
              child: FilterTimeWidget(
                selectedMainFilterIndex: selectedMainFilterIndex,
                onSelect: (selected) {
                  setState(() {
                    selectedMainFilterIndex = selected;
                  });
                },
              ),
            ),
            SliverFillRemaining(
              child: selectedMainFilterIndex == 0
                  ? const TodayView()
                  : const WeeklyView(),
            ),
          ],
        ),
      ),
    );
  }
}
