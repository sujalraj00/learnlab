import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnlab/auth/pages/on_boarding_page.dart';
import 'package:learnlab/features/widgets/animation_loader.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context:
            Get.overlayContext!, // we use overlay context for overlay dialogs
        barrierDismissible:
            false, // this dialog can't be dismissed by tapping outside it
        builder: (_) => PopScope(
              canPop: false, // disable popping with back button
              child: Container(
                color: THelperFunctions.isDarkMode(Get.context!)
                    ? TColors.dark
                    : TColors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 250,
                    ),
                    TAnimationLoaderWidget(text: text, animation: animation),
                  ],
                ),
              ),
            ));
  }

  //stop the currently open loading dialog
  // this method doesn't run anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // close the dialog using navigator
  }
}
