import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnlab/auth/controller/onboarding_controller.dart';
import 'package:learnlab/auth/pages/on_boarding_page.dart';
import 'package:learnlab/features/widgets/onboarding_dot_navigation.dart';
import 'package:learnlab/features/widgets/onboarding_nextbutton.dart';
import 'package:learnlab/features/widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          // horizontal scrollable page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                  image: "assets/onboarding/onboard0.png",
                  title: "Stay Connected",
                  subTitle:
                      "Welcome to a World of Limitless Choices - Always Stay connected with people who matters for you...!"),
              OnBoardingPage(
                  image: "assets/onboarding/onboard2.png",
                  title: "Set Reminders",
                  subTitle:
                      "For Seamless Experience, Set- Your Reminders, and get notified"),
              OnBoardingPage(
                  image: "assets/onboarding/onboard1.png",
                  title: "Send Message",
                  subTitle: "Send your reminders as a message to anyone"),
            ],
          ),
          // skip button
          const OnBoardingSkip(),

          // dot navigation smooth page indicator
          const OnBoardingDotNavigation(),

          // circular button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
