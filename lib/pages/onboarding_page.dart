import 'package:arivu/pages/landing.dart';
import 'package:flutter/material.dart';
import 'package:arivu/pages/all_tasks_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'all_tasks_page.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/Onboarding_3.png',
      'title': 'Welcome',
      'description': 'Welcome to our app!',
      'buttonText': 'Next'
    },
    {
      'image': 'assets/images/Onboarding_1.png',
      'title': 'Feature 1',
      'description': 'Description for Feature 1',
      'buttonText': 'Next'
    },
    {
      'image': 'assets/images/Onboarding_2.png',
      'title': 'Feature 2',
      'description': 'Description for Feature 2',
      'buttonText': 'Get Started'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          final page = _pages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(page['image']!, height: 300.0),
                Text(
                  page['title']!,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Text(page['description']!, textAlign: TextAlign.center),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (index >
                        0) // Show the previous button only if not on the first page
                      ElevatedButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text('Previous'),
                      ),
                    if (index > 0)
                      SizedBox(width: 16), // Add spacing between buttons
                    ElevatedButton(
                      onPressed: () {
                        if (index == _pages.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Landing()),
                          );
                        } else {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Text(page['buttonText']!),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    dotColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
