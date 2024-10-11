import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          habitCard(
              'Set Small Goals',
              'Everyday',
              ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              [true, true, true, true, true, true, false]),
          SizedBox(height: 10.h),
          habitCard(
              'Meditation',
              '5 days per week',
              ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              [true, true, true, true, false, false, false]),
          SizedBox(height: 10.h),
          habitCard(
              'Meditation',
              '5 days per week',
              ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              [true, true, true, true, false, false, false]),
          SizedBox(height: 10.h),
          habitCard(
              'Meditation',
              '5 days per week',
              ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              [true, true, true, true, false, false, false]),
        ],
      ),
    );
  }

  Widget habitCard(String habitName, String frequency, List<String> days,
      List<bool> checkboxes) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  habitName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: kOnSecondaryColor,
                  ),
                ),
                const Spacer(),
                Text(
                  frequency,
                  style: const TextStyle(color: kSecondaryColor),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 1,
              color: kHintColor,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(days.length, (index) {
                return Column(
                  children: [
                    Text(
                      days[index],
                      style: const TextStyle(
                        color: kSecondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 33.w,
                        height: 33.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: checkboxes[index]
                              ? Colors.pinkAccent
                              : Colors.transparent,
                          border: checkboxes[index]
                              ? null
                              : Border.all(
                                  color: kHintColor,
                                  width: 1.w,
                                ),
                        ),
                        child: checkboxes[index]
                            ? Icon(
                                Icons.check,
                                color: kOnSecondaryColor,
                                size: 16.sp,
                              )
                            : null,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
