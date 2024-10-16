// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/methods/navigation.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/home/view/layout/navigator_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: 'Set Your Goals',
      description:
          'Define the habits you want to build and set achievable goals.',
      image: Icons.flag, // Represents goal setting
    ),
    OnboardingPageModel(
      title: 'Track Your Progress',
      description: 'Monitor your daily habits and see your progress over time.',
      image: Icons.show_chart, // Represents tracking progress
    ),
    OnboardingPageModel(
      title: 'Stay Motivated',
      description:
          'Receive reminders and celebrate your streaks to stay on track.',
      image: Icons.notifications, // Represents motivation and reminders
    ),
    OnboardingPageModel(
      title: 'Achieve Success',
      description:
          'Consistently track your habits and achieve your personal goals.',
      image: Icons.emoji_events, // Represents success and achievement
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToHome() {
    replace(const NavigatorScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                model: pages[index],
              );
            },
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip Button
                TextButton(
                  onPressed: () {
                    navigateToHome();
                  },
                  child: const Text('Skip', style: TextStyles.h3),
                ),
                // Dots Indicator
                Row(
                  children: List.generate(
                    pages.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                // Next or Done Button
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: kSecondaryColor.withOpacity(0.7)),
                  onPressed: () {
                    if (currentIndex == pages.length - 1) {
                      navigateToHome();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                      currentIndex == pages.length - 1 ? 'Done' : 'Next',
                      style: TextStyles.h3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 20 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: currentIndex == index ? kPrimaryColor : kSecondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final IconData image;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel model;

  OnboardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            model.image,
            size: 100,
            color: kPrimaryColor,
          ),
          const SizedBox(height: 30),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            model.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: kSecondaryColor),
          ),
        ],
      ),
    );
  }
}
