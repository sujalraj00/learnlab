import 'package:flutter/material.dart';

import 'package:learnlab/auth/pages/on_boarding_page.dart';

import '../../auth/controller/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        right: 24,
        bottom: kBottomNavigationBarHeight,
        child: ElevatedButton(
            onPressed: () => OnBoardingController.instance.nextPage(),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? TColors.primary : Colors.black),
            child: const Icon(Icons.keyboard_arrow_right_rounded)));
  }
}
